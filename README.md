## Steps
### DB
1. Run [MariaDB-DDL.sql](https://github.com/p-hatz/Boomi-Test-Harness/blob/main/MariaDB-DDL.sql)
### AtomSphere
2. Use the [Component Creation API](https://developer.boomi.com/api/platformapi#tag/Component) to create the **(wsvc) 0. Create API Test** process [(wsvc) 0. Create API Test.xml](https://github.com/p-hatz/Boomi-Test-Harness/blob/main/(wsvc)%200.%20Create%20API%20Test.xml) (reuse your existing Connections to limit the impact on licencing)
3. Use the [Component Creation API](https://developer.boomi.com/api/platformapi#tag/Component) to create the **(wsvc) 1. Test Controller** process [(wsvc) 1. Test Controller.xml](https://github.com/p-hatz/Boomi-Test-Harness/blob/main/(wsvc)%201.%20Test%20Controller.xml) (reuse your existing Connections to limit the impact on licencing)
### (wsvc) 0. Create API Test Process
4. Update the `Globs` Shape
    - `dppAccountId` to your AtomSphere Account Id
    - `dppEnvId` to your AtomSphere Environment Id where the Test Harness will be deployed
    - `dppProdIdController` to the UUID of `(wsvc) 1. Test Controller`
5. Update the `(conn) AtomSphere API` (Boomi AtomSphere API) Connection
    - WSDL
    - Username
    - API Token or Password
6. Update the `(conn) AtomSphere API` (HTTP) Connection
    - Username
    - Password
7. Update the `(conn) MariaDB` Connection (or whichever DB Connection you'll be using)
    - Connection URL
    - User Name
    - Password
8. Update the `(oper) Process Test Suite (DELETE)` Operation
    - Schema
9. Update the `(oper) Process Test Suite (INSERT)` Operation
    - Schema
10. Update the `(oper) ComponentDef (INSERT)` Operation
    - Schema
### (wsvc) 1. Test Controller Process
11. Update the `(conn) MariaDB` Connection (or whichever DB Connection you'll be using)
    - Connection URL
    - User Name
    - Password
### Call the Create API Test Process
12. Provide the Id of the Process under test
    {
      "processId": "5b9cf704-3f42-4e40-b0fd-5027a400e90a"
    }

    You should get something like
    "Clone da3ba1f4-0f18-4b40-a149-9a54c01248b9 created from 5b9cf704-3f42-4e40-b0fd-5027a400e90a"
### Call the Test Controller Process
13. Provide the Clone Id and the Id of the Process under test
    {
      "processIdParent": "5b9cf704-3f42-4e40-b0fd-5027a400e90a",
      "processIdChild": "da3ba1f4-0f18-4b40-a149-9a54c01248b9",
      "testSuiteId": 1
    }

    Each Test Case in the Test Suite (1) should be run, where you will get a `0` for Success and `1` for Fail
