using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VisaFusion.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddAdminAuditLogAndSecurityDateIndex : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "adminauditlog",
                columns: table => new
                {
                    Id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    EventType = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false),
                    ActorUserId = table.Column<string>(type: "nvarchar(450)", maxLength: 450, nullable: false),
                    ActorUserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    TargetUserId = table.Column<string>(type: "nvarchar(450)", maxLength: 450, nullable: true),
                    TargetUserName = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: true),
                    Role = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: true),
                    Date = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Detail = table.Column<string>(type: "nvarchar(512)", maxLength: 512, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_adminauditlog", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_security_date1",
                table: "security",
                column: "date1",
                unique: true,
                filter: "[date1] IS NOT NULL");

            migrationBuilder.CreateIndex(
                name: "IX_adminauditlog_Date",
                table: "adminauditlog",
                column: "Date");

            migrationBuilder.CreateIndex(
                name: "IX_adminauditlog_EventType",
                table: "adminauditlog",
                column: "EventType");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "adminauditlog");

            migrationBuilder.DropIndex(
                name: "IX_security_date1",
                table: "security");
        }
    }
}
