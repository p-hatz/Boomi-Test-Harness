## Steps
### DB
1. Run [MariaDB-DDL.sql](https://github.com/p-hatz/Boomi-Test-Harness/blob/main/MariaDB-DDL.sql)
### AtomSphere
2. Use the [Component Creation API](https://developer.boomi.com/api/platformapi#tag/Component) to create the **0. Create API Test** process [(wsvc) 0. Create API Test.xml](https://github.com/p-hatz/Boomi-Test-Harness/blob/main/(wsvc)%200.%20Create%20API%20Test.xml)
3. Use the [Component Creation API](https://developer.boomi.com/api/platformapi#tag/Component) to create the **(wsvc) 1. Test Controller** process [(wsvc) 0. Create API Test.xml](https://github.com/p-hatz/Boomi-Test-Harness/blob/main/(wsvc)%200.%20Create%20API%20Test.xml)
4. Update `Globs` Shape
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
