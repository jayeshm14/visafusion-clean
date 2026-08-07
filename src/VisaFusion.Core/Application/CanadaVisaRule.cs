namespace VisaFusion.Core.Application;

/// <summary>
/// Representative shared business rule (SPEC-0003 T038, AC-003, TS-003).
///
/// Canada visa DOB validation: a passenger applying for a Canada visa must be at
/// least 18 years old on the application date. This concrete, testable rule proves
/// the shared-Core surface — it is invoked by both the Web service and the employee
/// representative Api endpoint (T045) and must return the same result from both.
///
/// NOTE: This is the scaffolding representative rule. The authoritative Canada
/// business rules (and any other country rules) are defined in the module feature
/// specs; this method is the wiring proof, not the final business logic.
/// </summary>
public interface ICanadaDobRule
{
    /// <summary>
    /// Validates that a passenger is at least 18 years old on the given date.
    /// </summary>
    /// <param name="dateOfBirth">The passenger's date of birth.</param>
    /// <param name="onDate">The reference date (defaults to today).</param>
    /// <returns>True when the passenger is 18 or older on <paramref name="onDate"/>.</returns>
    bool IsAdultForCanadaVisa(DateOnly dateOfBirth, DateOnly? onDate = null);
}

/// <summary>Default implementation of <see cref="ICanadaDobRule"/>.</summary>
public sealed class CanadaDobRule : ICanadaDobRule
{
    private const int MinimumAge = 18;

    public bool IsAdultForCanadaVisa(DateOnly dateOfBirth, DateOnly? onDate = null)
    {
        var reference = onDate ?? DateOnly.FromDateTime(DateTime.Today);
        var age = reference.Year - dateOfBirth.Year;

        // Adjust for the birthday not yet reached in the reference year.
        if (dateOfBirth > reference.AddYears(-age))
        {
            age--;
        }

        return age >= MinimumAge;
    }
}