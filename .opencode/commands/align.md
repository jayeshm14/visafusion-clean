---
description: Ground-check recent work against actual code and source docs before proceeding — catches hallucinated identifiers and drift from existing patterns.
agent: visafusion
---

Run a grounding audit on the work done so far this session, before continuing.
Do not rely on memory of what you already wrote or read — re-verify each item
below with an actual tool call now.

1. **List every factual claim made this session** about the codebase (a file/
   table/column/proc/endpoint/config-key existing, or behaving a certain way)
   that has NOT yet been confirmed by a `read`/`grep`/codegraph call in this
   session. For each one, verify it now. If it doesn't check out, flag it and
   stop using it.

2. **Re-open every file you're about to edit or already edited this session**
   and confirm its current on-disk content matches what you believe it to be.
   Report any mismatch.

3. **Pattern consistency check.** For any new code written this session,
   `grep`/codegraph-search for the nearest equivalent existing pattern in the
   repo (naming, layering, DI, error handling) and confirm the new code
   actually matches it. Report any place it doesn't, with the specific file
   and line that shows the divergent existing pattern.

4. **Citation check.** For every `@library/...` or `@findings/...` citation
   used this session, confirm the cited file still says what it was cited as
   saying — quote the exact line/row, don't paraphrase from memory.

5. **Report format:** a short pass/fail list — one line per item, "verified"
   or "MISMATCH: <what's wrong and where>". Do not restate work that already
   passed in earlier sections of this session; only report new findings from
   this audit.

If any MISMATCH is found, stop before continuing implementation and propose
the fix — do not silently patch and move on without surfacing it.
