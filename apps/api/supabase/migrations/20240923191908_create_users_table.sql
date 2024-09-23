CREATE TYPE "public"."user_role_enum" AS ENUM (
  'viewer',
  'owner'
);

CREATE TABLE IF NOT EXISTS "public"."users" (
  id uuid PRIMARY KEY NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  role user_role_enum DEFAULT 'viewer' NOT NULL,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT now(),
  CONSTRAINT fk_auth_user FOREIGN KEY ( id ) REFERENCES auth.users( id ) ON DELETE CASCADE
);

ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public users are viewable only by authenticated users."
ON "public"."users" FOR SELECT TO authenticated USING ( true );

CREATE POLICY "Users can only be updated by the owner."
ON "public"."users" FOR UPDATE TO authenticated
USING ( ( SELECT auth.uid() ) = id )
WITH CHECK ( ( SELECT auth.uid() ) = id );

CREATE OR REPLACE FUNCTION public.handle_new_user() RETURNS trigger
LANGUAGE plpgsql SECURITY definer SET search_path = 'public'
AS $$
BEGIN
  INSERT INTO "public"."users" ( id, first_name, last_name )
  VALUES ( 
    new.id, 
    new.raw_user_meta_data ->> 'first_name', 
    new.raw_user_meta_data ->> 'last_name'
  );
  RETURN new;
END;
$$;

CREATE OR REPLACE TRIGGER on_auth_user_created
AFTER INSERT ON auth.users
FOR each ROW EXECUTE PROCEDURE public.handle_new_user();
