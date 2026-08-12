namespace VisaFusion.Migration.Identity;

/// <summary>
/// Legacy `active` flag parse rule for the identity import (SPEC-0005 T015,
/// US1, FR-009).
///
/// Verified live 2026-08-11 (legacy `VisaEntry` database): the column is
/// `varchar(1)` in all three sources — `agents` Y/N/NULL (3468/729/21),
/// `registration` all NULL (43), `Udaan_users` Y/NULL only (929/1436; no 'N'
/// rows exist). The legacy login never checks `active` (`authenticate.asp`),
/// and the only filter in the codebase is `where Active = 'Y'`
/// (`connection.asp` LoadListBox dropdown population).
///
/// An account is INACTIVE only when the value is explicitly 'N' — the
/// deactivation value the legacy writes (`addnewagents.asp` line 57 sets
/// `active="Y"` on creation). 'Y' and NULL (never-set) both mean active:
/// locking out NULL rows would change login behavior for the 1436 NULL
/// `Udaan_users` rows (47 adm, 9 emp of the currently logging-in base) and
/// all 43 registration guest accounts, which FR-009 does not intend — it
/// preserves the legacy flag meaning (`active = false`) while keeping every
/// account that can log in today able to log in.
/// </summary>
public static class IdentityActive
{
    public static bool IsInactive(string? activeValue)
        => string.Equals(activeValue?.Trim(), "N", StringComparison.OrdinalIgnoreCase);
}
