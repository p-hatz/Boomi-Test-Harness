## Steps
### DB
1. Run [MariaDB-DDL.sql](https://github.com/p-hatz/Boomi-Test-Harness/blob/main/MariaDB-DDL.sql)
2. The following tables need to be populated
    - `testSuite`: Test Suite data
    - `testCase`: Test Case data
    - `testCaseExpected`: Expected Test Case data
### AtomSphere
3. Install the Bundle located at https://platform.boomi.com/BoomiLabs.html#pub_bundles;/tab=my_bundles/bundle=1cbe864a-5781-4c3c-afba-8b5e5a549811/bundleOwner=true
4. Open the Process `(wsvc) 0. Create API Test Process` from the AtomSphere Folder you installed the Bundle in and update the following (or reuse any existing connection(s))<br>
   i. Update the `Globs` Shape
   * `dppAccountId` to your AtomSphere Account Id
   * `dppEnvId` to your AtomSphere Environment Id where the Test Harness will be deployed
   * `dppProdIdController` to the UUID of `(wsvc) 1. Test Controller`
5. Package and Deploy the Process
6. Package and Deploy the Process
7. Update the `Controller Component Definition` shape in the `(wsvc) 0. Create API Test` process, as this creates the `(wsvc) 1. Test Controller` based on Step 4 (the `connectionId`, (possibly) `connectorType`, `operationId` and `parameter-profile` values will change once the `(wsvc) 1. Test Controller` process is created)
9. Update the `(conn) AtomSphere API` (Boomi AtomSphere API) Connection
    - WSDL
    - Username
    - API Token or Password
10. Update the `(conn) AtomSphere API` (HTTP) Connection
    - Username
    - Password
11. Update the `(conn) MariaDB` Connection (or whichever DB Connection you'll be using)
    - Connection URL
    - User Name
    - Password
12. Update the `(oper) Process Test Suite (DELETE)` Operation
    - Schema
13. Update the `(oper) Process Test Suite (INSERT)` Operation
    - Schema
14. Update the `(oper) ComponentDef (INSERT)` Operation
    - Schema
### (wsvc) 1. Test Controller Process
15. Update the `(conn) MariaDB` Connection (or whichever DB Connection you'll be using)
    - Connection URL
    - User Name
    - Password
### Call the Create API Test Process
16. Provide the Id of the Process under test
>     {
>       "processId": "5b9cf704-3f42-4e40-b0fd-5027a400e90a"
>     }
You should get something like<br>
_Clone da3ba1f4-0f18-4b40-a149-9a54c01248b9 created from 5b9cf704-3f42-4e40-b0fd-5027a400e90a (Test Suite Id: 7)_
### Call the Test Controller Process
17. Provide the Clone Id and the Id of the Process under test
>     {
>       "processIdParent": "5b9cf704-3f42-4e40-b0fd-5027a400e90a",
>       "processIdChild": "da3ba1f4-0f18-4b40-a149-9a54c01248b9",
>       "testSuiteId": 1
>     }
> 

Each Test Case in the Test Suite (1) should be run, where you will get a `0` for Success and `1` for Fail
