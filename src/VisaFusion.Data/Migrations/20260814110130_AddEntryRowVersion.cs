using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VisaFusion.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddEntryRowVersion : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<byte[]>(
                name: "rowversion",
                table: "Mainentry",
                type: "rowversion",
                rowVersion: true,
                nullable: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "rowversion",
                table: "Mainentry");
        }
    }
}
