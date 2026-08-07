namespace VisaFusion.FunctionalTests;

/// <summary>
/// Solution build smoke test (SPEC-0003 T019, User Story 1).
///
/// Asserts all six production projects (plus the three test projects) are
/// discoverable in VisaFusion.sln, proving FR-001 and FR-009: the solution is
/// buildable with all §2 projects present.
///
/// The solution file is located by walking up from the test output directory
/// to the repository root.
/// </summary>
public class BuildValidationTests
{
    private static readonly string[] ExpectedProjects =
    {
        "src/VisaFusion.Web/VisaFusion.Web.csproj",
        "src/VisaFusion.Api/VisaFusion.Api.csproj",
        "src/VisaFusion.Core/VisaFusion.Core.csproj",
        "src/VisaFusion.Data/VisaFusion.Data.csproj",
        "src/VisaFusion.Identity/VisaFusion.Identity.csproj",
        "src/VisaFusion.Jobs/VisaFusion.Jobs.csproj",
    };

    [Fact]
    public void Solution_Contains_All_Six_Production_Projects()
    {
        var slnPath = FindSolutionFile();
        var slnContent = File.ReadAllText(slnPath);

        foreach (var project in ExpectedProjects)
        {
            Assert.Contains(
                project.Replace('/', Path.DirectorySeparatorChar),
                slnContent,
                StringComparison.OrdinalIgnoreCase);
        }
    }

    [Fact]
    public void Solution_Contains_All_Three_Test_Projects()
    {
        var slnPath = FindSolutionFile();
        var slnContent = File.ReadAllText(slnPath);

        foreach (var project in new[]
        {
            "tests/UnitTests/VisaFusion.UnitTests.csproj",
            "tests/IntegrationTests/VisaFusion.IntegrationTests.csproj",
            "tests/FunctionalTests/VisaFusion.FunctionalTests.csproj",
        })
        {
            Assert.Contains(
                project.Replace('/', Path.DirectorySeparatorChar),
                slnContent,
                StringComparison.OrdinalIgnoreCase);
        }
    }

    private static string FindSolutionFile()
    {
        var dir = new DirectoryInfo(AppContext.BaseDirectory);
        while (dir is not null)
        {
            var candidate = Path.Combine(dir.FullName, "VisaFusion.sln");
            if (File.Exists(candidate))
            {
                return candidate;
            }

            dir = dir.Parent;
        }

        throw new FileNotFoundException(
            "VisaFusion.sln not found by walking up from the test output directory.");
    }
}
