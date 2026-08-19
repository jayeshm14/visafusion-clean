using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VisaFusion.Data.Migrations
{
    /// <inheritdoc />
    public partial class AddQueriesAndEmailQueue : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "emailQueue",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    toemail = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    subject = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    body = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    agentsid = table.Column<int>(type: "int", nullable: true),
                    refno = table.Column<int>(type: "int", nullable: true),
                    awb = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: true),
                    sentby = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: true),
                    sentdate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_emailQueue", x => x.Id);
                    table.ForeignKey(
                        name: "FK_emailQueue_agents_agentsid",
                        column: x => x.agentsid,
                        principalTable: "agents",
                        principalColumn: "agentsID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "queries",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    email = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    subject = table.Column<string>(type: "nvarchar(256)", maxLength: 256, nullable: false),
                    message = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    subdate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    status = table.Column<string>(type: "nvarchar(16)", maxLength: 16, nullable: false, defaultValue: "new"),
                    ip_address = table.Column<string>(type: "nvarchar(64)", maxLength: 64, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_queries", x => x.Id);
                });

            migrationBuilder.CreateIndex(
                name: "IX_emailQueue_agentsid",
                table: "emailQueue",
                column: "agentsid");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "emailQueue");

            migrationBuilder.DropTable(
                name: "queries");
        }
    }
}
