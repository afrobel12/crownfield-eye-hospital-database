# Crownfield Eye Hospital — CPU4:103 individual MySQL project

A teaching prototype for a fictional ophthalmology hospital. Includes 11 related MySQL tables, synthetic records, individual queries, a stored procedure and trigger, roles, transaction tests and a Workbench-exported EER diagram. No real patient data is included.

## Environment

- MySQL Community Server 26.7.0 on macOS (Intel), executed in MySQL Workbench.
- Standard SQL structures target MySQL 8.0.16+; other releases have not been tested here.
- Database schema: `crownfield_eye_hospital`.

## Run on a fresh database (in this order)

1. `00_create_database_and_patient.sql` — creates the schema and base `patient` table; does not delete existing data.
2. `01_schema.sql` — adds postcode and creates the other 10 tables and their keys. **Run once only**.
3. `02_sample_data.sql` — populates the tables with fictional Appendix 1-related and extra synthetic records. **Run once only**.
4. `03_individual_queries.sql` — four SQL queries: aggregate with HAVING, four-table INNER JOIN, LEFT JOIN, and subquery.
5. `04_procedure_and_trigger.sql` — parametrised procedure and follow-up trigger, plus demonstration queries.
6. `05_security.sql` — creates four roles, grants permissions, demonstrates hashing. Run only with an account authorised to create roles and grant permissions.
7. `06_transactions_and_tests.sql` — demonstrates UPDATE/ROLLBACK, safe INSERT/DELETE/COMMIT and checks.

To run: open each file with **File > Open SQL Script** in MySQL Workbench, execute the entire script, and inspect Action Output. **Do not execute the setup scripts repeatedly**: the seed script would create duplicate-key errors and the schema file would attempt to add an existing column.

### If using the already-completed coursework installation

The above scripts have already been executed and evidenced in Workbench. **Do not rerun 00, 01 or 02** on that populated database. The bootstrap file is included so someone using a fresh MySQL installation can reproduce the schema without manually recreating the first `patient` table.

## Entity relationship diagram

- `05_ERD/Crownfield_Eye_Hospital_ERD.png` — the diagram exported from the student's MySQL Workbench model.
- `05_ERD/relationships.mmd` — optional Mermaid relationship representation.

## Sources, assumptions and limitations

- Appendix 1 supplies the original example patient/visit context; additional records and patient birth dates are fictional coursework placeholders. Synthetic medication dosage strings are **not clinical advice**.
- Patient identifiers are character codes such as `OP001`. The `patient` table uses `VARCHAR(10)` and referencing columns use `VARCHAR(12)`; this is a minor consistency improvement for future revision.
- Database roles do **not** create real staff accounts or implement per-patient row-level access. The token SHA-256 example illustrates hashing; production authentication should use an adaptive, salted password hash.
- The example trigger and transaction script include temporary demonstration records and cleanup. Some negative validation examples remain commented and are not represented as successful tests.
- All objects are in a local teaching database; this repository does not contain server credentials, connection strings or recovery files.

## Evidence and submission

The individual report contains the annotated screenshots and technical discussion. The SQL scripts are supplied here as the runnable code. Verify your own GitHub URL and required submission route with the module instructions.
