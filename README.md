## Steps
1. Update `Globs` Shape
    - `dppAccountId` to your AtomSphere Account Id
    - `dppEnvId` to your AtomSphere Environment Id where the Test Harness will be deployed
    - `dppProdIdController` to the UUID of `(wsvc) 1. Test Controller - Main`
2. Update the `(conn) AtomSphere API` (Boomi AtomSphere API) Connections
    - WSDL
    - Username
    - API Token or Password
3. Update the `(conn) AtomSphere API` (HTTP) Connection
    - Username
    - Password
4. Update the `(conn) MariaDB` Connection (or whichever DB Connection you'll be using)
    - Connection URL
    - User Name
    - Password
5. Update the `(oper) Process Test Suite (DELETE)` Operation
    - Schema
6. Update the `(oper) Process Test Suite (INSERT)` Operation
    - Schema
7. Update the `(oper) ComponentDef (INSERT)` Operation
    - Schema
