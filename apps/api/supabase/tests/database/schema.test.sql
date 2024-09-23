BEGIN;
SELECT plan( 2 );

SELECT has_schema( 'public', 'public schema should exist' );

SELECT has_schema( 'auth', 'auth schema should exist' );

SELECT * FROM finish();
ROLLBACK;
