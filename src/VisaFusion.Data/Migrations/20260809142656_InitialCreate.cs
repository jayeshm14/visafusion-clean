using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace VisaFusion.Data.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "agents",
                columns: table => new
                {
                    agentsID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    companyname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    complexname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    street1 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    street2 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    area = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    city = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    pincode = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    phoneno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    faxno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    emailid = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    directorname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    acno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    payment = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    active = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TAAI = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TAFI = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    MEMBERSHIP = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    CREATIONDATE = table.Column<DateTime>(type: "datetime2", nullable: true),
                    IATA = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DirectorPH = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AcMgrPH = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    VisaInchargeName = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    VisaInchargePH = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    enteredby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    smsno = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_agents", x => x.agentsID);
                });

            migrationBuilder.CreateTable(
                name: "Attestation",
                columns: table => new
                {
                    AttestationID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Attestation", x => x.AttestationID);
                });

            migrationBuilder.CreateTable(
                name: "bank",
                columns: table => new
                {
                    bankid = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Active = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_bank", x => x.bankid);
                });

            migrationBuilder.CreateTable(
                name: "bighistory",
                columns: table => new
                {
                    bighistoryid = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: true),
                    agent = table.Column<int>(type: "int", nullable: true),
                    Date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    UpdatedBy = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Remarks = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_bighistory", x => x.bighistoryid);
                });

            migrationBuilder.CreateTable(
                name: "cab",
                columns: table => new
                {
                    cabid = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_cab", x => x.cabid);
                });

            migrationBuilder.CreateTable(
                name: "Category",
                columns: table => new
                {
                    CategoryID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Active = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Category", x => x.CategoryID);
                });

            migrationBuilder.CreateTable(
                name: "certificate",
                columns: table => new
                {
                    certificateID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_certificate", x => x.certificateID);
                });

            migrationBuilder.CreateTable(
                name: "CountryInfo",
                columns: table => new
                {
                    CountryID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    About = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Climate = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Language = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Religion = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Curency = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    TimeZone = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Continent_File = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Flag_File = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Visa_File = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_CountryInfo", x => x.CountryID);
                });

            migrationBuilder.CreateTable(
                name: "dailyUpdate",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    entrydate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_dailyUpdate", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "deleteditem",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: true),
                    paxid = table.Column<int>(type: "int", nullable: true),
                    countryid = table.Column<int>(type: "int", nullable: true),
                    deletedby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_deleteditem", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "embassy",
                columns: table => new
                {
                    EmbassyID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    embassyname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    street1 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    street2 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    area = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    city = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    phoneno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    faxno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    emailid = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    workinghours = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    chancery = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    chanceryphone = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    chanceryaddress = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    active = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_embassy", x => x.EmbassyID);
                });

            migrationBuilder.CreateTable(
                name: "EntryType",
                columns: table => new
                {
                    EntryTypeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Active = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_EntryType", x => x.EntryTypeID);
                });

            migrationBuilder.CreateTable(
                name: "holidaylist",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    countryID = table.Column<int>(type: "int", nullable: true),
                    holiday = table.Column<DateTime>(type: "datetime2", nullable: true),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_holidaylist", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "hotel",
                columns: table => new
                {
                    hotelid = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_hotel", x => x.hotelid);
                });

            migrationBuilder.CreateTable(
                name: "invoice",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: true),
                    invoiceno = table.Column<int>(type: "int", nullable: false),
                    hotelfee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    cabfee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    poeremark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    poe = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    miscremark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    misc = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    attestfee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    attestremark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    courierfee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    grandtotal = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    invoicedate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    remark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    invtype = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_invoice", x => x.Id);
                    table.UniqueConstraint("IX_invoice_invoiceno", x => x.invoiceno);
                });

            migrationBuilder.CreateTable(
                name: "Ledger",
                columns: table => new
                {
                    id = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    agentID = table.Column<int>(type: "int", nullable: true),
                    transdate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    transactionType = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    bank = table.Column<int>(type: "int", nullable: true),
                    paidas = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ddno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    dddate = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    paxname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    refno = table.Column<int>(type: "int", nullable: true),
                    reftype = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    credit = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    Debit = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    balance = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    Remark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    entrydateTime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    updatedby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    invno = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Ledger", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "masterbalance",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    agentid = table.Column<int>(type: "int", nullable: true),
                    masterbalance = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    duedate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_masterbalance", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "newagents",
                columns: table => new
                {
                    newagentsID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    companyname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    complexname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    street1 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    street2 = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    area = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    city = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    pincode = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    phoneno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    faxno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    emailid = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    directorname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    acno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    payment = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_newagents", x => x.newagentsID);
                });

            migrationBuilder.CreateTable(
                name: "paxCab",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: true),
                    name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    cabowner = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    vehical = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    cabno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ac = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sdate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    enddate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    startfrom = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    standeredkm = table.Column<int>(type: "int", nullable: true),
                    standeredhour = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    actualkm = table.Column<int>(type: "int", nullable: true),
                    actualhour = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    extrakm = table.Column<int>(type: "int", nullable: true),
                    extrahour = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    extrainfo = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    extraamount = table.Column<int>(type: "int", nullable: true),
                    mode = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    dest = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    orderedby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    ratesperday = table.Column<int>(type: "int", nullable: true),
                    noofday = table.Column<int>(type: "int", nullable: true),
                    total = table.Column<int>(type: "int", nullable: true),
                    entryDateTime = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_paxCab", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "paxhotel",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: true),
                    name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    hotelname = table.Column<int>(type: "int", nullable: true),
                    arrivaltime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    arrivaldate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    departtime = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    departdate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    nosofdays = table.Column<int>(type: "int", nullable: true),
                    tariff = table.Column<int>(type: "int", nullable: true),
                    transportation = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    flightdetail = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    flightstatus = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    misccharges = table.Column<int>(type: "int", nullable: true),
                    total = table.Column<int>(type: "int", nullable: true),
                    noofrooms = table.Column<int>(type: "int", nullable: true),
                    entryDateTime = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_paxhotel", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "Poe",
                columns: table => new
                {
                    PoeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Active = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Poe", x => x.PoeID);
                });

            migrationBuilder.CreateTable(
                name: "priwork",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    givenby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    edate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    work = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    status = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_priwork", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "scheduler",
                columns: table => new
                {
                    messageid = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    date = table.Column<DateTime>(type: "datetime2", nullable: false),
                    messageto = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    messagefrom = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    subject = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    messageread = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sentdate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_scheduler", x => x.messageid);
                });

            migrationBuilder.CreateTable(
                name: "security",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    date1 = table.Column<DateTime>(type: "datetime2", nullable: true),
                    openingtime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    openby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    closingtime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    closedby = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_security", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "sentawb",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    agentsid = table.Column<int>(type: "int", nullable: false),
                    date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    toemail = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    remark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    awb = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_sentawb", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "sentmails",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    agentsid = table.Column<int>(type: "int", nullable: false),
                    date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    toemail = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    awb = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_sentmails", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "smshistory",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    cellno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    refno = table.Column<int>(type: "int", nullable: true),
                    agentID = table.Column<int>(type: "int", nullable: true),
                    paxname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    status = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    message = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sentby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sentdate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_smshistory", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "status",
                columns: table => new
                {
                    statusID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Description = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Active = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_status", x => x.statusID);
                });

            migrationBuilder.CreateTable(
                name: "subscriber",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    name = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    email = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_subscriber", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "smsQueue",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    cellno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    refno = table.Column<int>(type: "int", nullable: true),
                    agentID = table.Column<int>(type: "int", nullable: true),
                    paxname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Message = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sentby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sentdate = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_smsQueue", x => x.Id);
                    table.ForeignKey(
                        name: "FK_smsQueue_agents_agentID",
                        column: x => x.agentID,
                        principalTable: "agents",
                        principalColumn: "agentsID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "VisaInfo",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    countryID = table.Column<int>(type: "int", nullable: true),
                    categoryID = table.Column<int>(type: "int", nullable: true),
                    information = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    countryFor = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_VisaInfo", x => x.Id);
                    table.ForeignKey(
                        name: "FK_VisaInfo_Category_categoryID",
                        column: x => x.categoryID,
                        principalTable: "Category",
                        principalColumn: "CategoryID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "weeklyoff",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    embassyid = table.Column<int>(type: "int", nullable: true),
                    weekend = table.Column<int>(type: "int", nullable: true),
                    description = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_weeklyoff", x => x.Id);
                    table.ForeignKey(
                        name: "FK_weeklyoff_embassy_embassyid",
                        column: x => x.embassyid,
                        principalTable: "embassy",
                        principalColumn: "EmbassyID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "Mainentry",
                columns: table => new
                {
                    id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: false),
                    paxname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    agent = table.Column<int>(type: "int", nullable: true),
                    refferer = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    companyname = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    passportno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    totalpassengers = table.Column<int>(type: "int", nullable: true),
                    entries = table.Column<int>(type: "int", nullable: true),
                    dateofbirth = table.Column<DateTime>(type: "datetime2", nullable: true),
                    subdate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    coldate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    receivedate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    traveldate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    sentDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    entrytype = table.Column<int>(type: "int", nullable: true),
                    category = table.Column<int>(type: "int", nullable: true),
                    attestation = table.Column<int>(type: "int", nullable: true),
                    poe = table.Column<int>(type: "int", nullable: true),
                    status = table.Column<int>(type: "int", nullable: true),
                    externalremark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    internalremark = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    AgentInstruction = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    enteredby = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    entrydatetime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Bill = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Mainentry", x => x.id);
                    table.UniqueConstraint("IX_Mainentry_refno", x => x.refno);
                    table.ForeignKey(
                        name: "FK_Mainentry_EntryType_entrytype",
                        column: x => x.entrytype,
                        principalTable: "EntryType",
                        principalColumn: "EntryTypeID",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_Mainentry_agents_agent",
                        column: x => x.agent,
                        principalTable: "agents",
                        principalColumn: "agentsID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "invoicedetail",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    invoiceno = table.Column<int>(type: "int", nullable: true),
                    paxid = table.Column<int>(type: "int", nullable: true),
                    countryid = table.Column<int>(type: "int", nullable: true),
                    visafee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    handlingfee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    ddcharges = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    invtype = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    VFSTTCharges = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_invoicedetail", x => x.Id);
                    table.ForeignKey(
                        name: "FK_invoicedetail_invoice_invoiceno",
                        column: x => x.invoiceno,
                        principalTable: "invoice",
                        principalColumn: "invoiceno",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "StatusHistory",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PaxID = table.Column<int>(type: "int", nullable: true),
                    Date = table.Column<DateTime>(type: "datetime2", nullable: true),
                    CountryID = table.Column<int>(type: "int", nullable: true),
                    StatusID = table.Column<int>(type: "int", nullable: true),
                    Remarks = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    UpdatedBy = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_StatusHistory", x => x.Id);
                    table.ForeignKey(
                        name: "FK_StatusHistory_status_StatusID",
                        column: x => x.StatusID,
                        principalTable: "status",
                        principalColumn: "statusID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "entryDetails",
                columns: table => new
                {
                    PaxID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: true),
                    Paxname = table.Column<string>(type: "nvarchar(450)", nullable: true),
                    passportno = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    DateOfBirth = table.Column<DateTime>(type: "datetime2", nullable: true),
                    Category = table.Column<int>(type: "int", nullable: true),
                    totalpax = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_entryDetails", x => x.PaxID);
                    table.ForeignKey(
                        name: "FK_entryDetails_Mainentry_refno",
                        column: x => x.refno,
                        principalTable: "Mainentry",
                        principalColumn: "refno",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "PaxStatus",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    refno = table.Column<int>(type: "int", nullable: true),
                    PaxID = table.Column<int>(type: "int", nullable: true),
                    CountryID = table.Column<int>(type: "int", nullable: true),
                    subdate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    coldate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    colcheck = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    sentDate = table.Column<DateTime>(type: "datetime2", nullable: true),
                    category = table.Column<int>(type: "int", nullable: true),
                    entrytype = table.Column<int>(type: "int", nullable: true),
                    statusID = table.Column<int>(type: "int", nullable: true),
                    remarks = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    visafee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    handlingfee = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    ddcharges = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    couriercharges = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    Misccharges = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    total = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true),
                    entrydatetime = table.Column<DateTime>(type: "datetime2", nullable: true),
                    VFSTTCharges = table.Column<decimal>(type: "decimal(19,4)", precision: 19, scale: 4, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PaxStatus", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PaxStatus_Mainentry_refno",
                        column: x => x.refno,
                        principalTable: "Mainentry",
                        principalColumn: "refno",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_PaxStatus_status_statusID",
                        column: x => x.statusID,
                        principalTable: "status",
                        principalColumn: "statusID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "PaxAttestation",
                columns: table => new
                {
                    Id = table.Column<long>(type: "bigint", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    PaxID = table.Column<int>(type: "int", nullable: true),
                    CountryID = table.Column<int>(type: "int", nullable: true),
                    AttestationID = table.Column<int>(type: "int", nullable: true),
                    CertificateID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PaxAttestation", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PaxAttestation_Attestation_AttestationID",
                        column: x => x.AttestationID,
                        principalTable: "Attestation",
                        principalColumn: "AttestationID",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_PaxAttestation_certificate_CertificateID",
                        column: x => x.CertificateID,
                        principalTable: "certificate",
                        principalColumn: "certificateID",
                        onDelete: ReferentialAction.Restrict);
                    table.ForeignKey(
                        name: "FK_PaxAttestation_entryDetails_PaxID",
                        column: x => x.PaxID,
                        principalTable: "entryDetails",
                        principalColumn: "PaxID",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_bighistory_refno",
                table: "bighistory",
                column: "refno");

            migrationBuilder.CreateIndex(
                name: "IX_entryDetails_Paxname",
                table: "entryDetails",
                column: "Paxname");

            migrationBuilder.CreateIndex(
                name: "IX_entryDetails_refno",
                table: "entryDetails",
                column: "refno");

            migrationBuilder.CreateIndex(
                name: "IX_invoice_refno",
                table: "invoice",
                column: "refno");

            migrationBuilder.CreateIndex(
                name: "IX_invoicedetail_invoiceno",
                table: "invoicedetail",
                column: "invoiceno");

            migrationBuilder.CreateIndex(
                name: "IX_Mainentry_agent",
                table: "Mainentry",
                column: "agent");

            migrationBuilder.CreateIndex(
                name: "IX_Mainentry_category",
                table: "Mainentry",
                column: "category");

            migrationBuilder.CreateIndex(
                name: "IX_Mainentry_entrytype",
                table: "Mainentry",
                column: "entrytype");

            migrationBuilder.CreateIndex(
                name: "IX_Mainentry_status",
                table: "Mainentry",
                column: "status");

            migrationBuilder.CreateIndex(
                name: "IX_PaxAttestation_AttestationID",
                table: "PaxAttestation",
                column: "AttestationID");

            migrationBuilder.CreateIndex(
                name: "IX_PaxAttestation_CertificateID",
                table: "PaxAttestation",
                column: "CertificateID");

            migrationBuilder.CreateIndex(
                name: "IX_PaxAttestation_PaxID",
                table: "PaxAttestation",
                column: "PaxID");

            migrationBuilder.CreateIndex(
                name: "IX_PaxStatus_PaxID",
                table: "PaxStatus",
                column: "PaxID");

            migrationBuilder.CreateIndex(
                name: "IX_PaxStatus_refno",
                table: "PaxStatus",
                column: "refno");

            migrationBuilder.CreateIndex(
                name: "IX_PaxStatus_statusID",
                table: "PaxStatus",
                column: "statusID");

            migrationBuilder.CreateIndex(
                name: "IX_sentawb_agentsid",
                table: "sentawb",
                column: "agentsid");

            migrationBuilder.CreateIndex(
                name: "IX_sentmails_agentsid",
                table: "sentmails",
                column: "agentsid");

            migrationBuilder.CreateIndex(
                name: "IX_smshistory_agentID",
                table: "smshistory",
                column: "agentID");

            migrationBuilder.CreateIndex(
                name: "IX_smshistory_refno",
                table: "smshistory",
                column: "refno");

            migrationBuilder.CreateIndex(
                name: "IX_smsQueue_agentID",
                table: "smsQueue",
                column: "agentID");

            migrationBuilder.CreateIndex(
                name: "IX_StatusHistory_Date",
                table: "StatusHistory",
                column: "Date");

            migrationBuilder.CreateIndex(
                name: "IX_StatusHistory_PaxID",
                table: "StatusHistory",
                column: "PaxID");

            migrationBuilder.CreateIndex(
                name: "IX_StatusHistory_StatusID",
                table: "StatusHistory",
                column: "StatusID");

            migrationBuilder.CreateIndex(
                name: "IX_VisaInfo_categoryID",
                table: "VisaInfo",
                column: "categoryID");

            migrationBuilder.CreateIndex(
                name: "IX_weeklyoff_embassyid",
                table: "weeklyoff",
                column: "embassyid");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "bank");

            migrationBuilder.DropTable(
                name: "bighistory");

            migrationBuilder.DropTable(
                name: "cab");

            migrationBuilder.DropTable(
                name: "CountryInfo");

            migrationBuilder.DropTable(
                name: "dailyUpdate");

            migrationBuilder.DropTable(
                name: "deleteditem");

            migrationBuilder.DropTable(
                name: "holidaylist");

            migrationBuilder.DropTable(
                name: "hotel");

            migrationBuilder.DropTable(
                name: "invoicedetail");

            migrationBuilder.DropTable(
                name: "Ledger");

            migrationBuilder.DropTable(
                name: "masterbalance");

            migrationBuilder.DropTable(
                name: "newagents");

            migrationBuilder.DropTable(
                name: "PaxAttestation");

            migrationBuilder.DropTable(
                name: "paxCab");

            migrationBuilder.DropTable(
                name: "paxhotel");

            migrationBuilder.DropTable(
                name: "PaxStatus");

            migrationBuilder.DropTable(
                name: "Poe");

            migrationBuilder.DropTable(
                name: "priwork");

            migrationBuilder.DropTable(
                name: "scheduler");

            migrationBuilder.DropTable(
                name: "security");

            migrationBuilder.DropTable(
                name: "sentawb");

            migrationBuilder.DropTable(
                name: "sentmails");

            migrationBuilder.DropTable(
                name: "smshistory");

            migrationBuilder.DropTable(
                name: "smsQueue");

            migrationBuilder.DropTable(
                name: "StatusHistory");

            migrationBuilder.DropTable(
                name: "subscriber");

            migrationBuilder.DropTable(
                name: "VisaInfo");

            migrationBuilder.DropTable(
                name: "weeklyoff");

            migrationBuilder.DropTable(
                name: "invoice");

            migrationBuilder.DropTable(
                name: "Attestation");

            migrationBuilder.DropTable(
                name: "certificate");

            migrationBuilder.DropTable(
                name: "entryDetails");

            migrationBuilder.DropTable(
                name: "status");

            migrationBuilder.DropTable(
                name: "Category");

            migrationBuilder.DropTable(
                name: "embassy");

            migrationBuilder.DropTable(
                name: "Mainentry");

            migrationBuilder.DropTable(
                name: "EntryType");

            migrationBuilder.DropTable(
                name: "agents");
        }
    }
}
