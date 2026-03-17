import { SQL } from 'bun';
import { beforeEach } from 'bun:test';

const result = await Bun.spawn(['bun', 'scripts/migrate.ts'], {
	env: { ...process.env, SQL_URL: process.env.TEST_SQL_URL! },
	stdout: 'inherit',
	stderr: 'inherit'
}).exited;

if (result !== 0) throw new Error(`Migration failed with exit code ${result}`);

const sql = new SQL(process.env.TEST_SQL_URL!);

beforeEach(async () => {
	const tables = await sql`
        SELECT tablename FROM pg_tables
        WHERE schemaname = 'public' AND tablename != 'schema_migrations'
    `;
	if (tables.length > 0) {
		const names = tables.map((t: { tablename: string }) => t.tablename).join(', ');
		await sql.unsafe(`TRUNCATE ${names} RESTART IDENTITY CASCADE`);
	}
});
