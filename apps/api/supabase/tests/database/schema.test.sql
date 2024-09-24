BEGIN;
SELECT plan( 10 );

SELECT has_schema( 'public', 'public schema should exist' );
SELECT has_schema( 'auth', 'auth schema should exist' );

SELECT has_table( 'public', 'users', 'users table should exist' );
SELECT has_column( 'public', 'users', 'id', 'id should exist' );
SELECT col_is_pk ( 'public', 'users', 'id', 'id is a primary key' );
SELECT has_column( 'public', 'users', 'first_name', 'first_name should exist' );
SELECT has_column( 'public', 'users', 'last_name', 'last_name should exist' );
SELECT has_column( 'public', 'users', 'role', 'role should exist' );
SELECT has_column( 'public', 'users', 'created_at', 'created_at should exist' );
SELECT has_column( 'public', 'users', 'updated_at', 'updated_at should exist' );


SELECT * FROM finish();
ROLLBACK;
