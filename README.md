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
   
    ii. Update the `(conn) AtomSphere API` (Boomi AtomSphere API) Connection
   * `WSDL`
   * `Username`
   * `API Token` or `Password`

   iii. Update the `(conn) AtomSphere API` (HTTP) Connection
   * `Username`
   * `Password`
  
   iv. Update the `(conn) MariaDB` Connection (or whichever DB Connection you'll be using)
   * `Connection URL`
   * `Class Name`
   * `Username` (with read/write access to the tables that were created in Step 1)
   * `Password`

   v. Update the following Operations to include the schema where the tables in Step 1 were created
   * `(oper) Test Suite (INSERT)`
   * `(oper) Test Suite (SELECT)`
   * `(oper) Process Test Suite (INSERT)`
   * `(oper) ComponentDef (INSERT)`
   
5. Package and Deploy the process
6. Get the Component definition for the `(wsvc) 1. Test Controller` using the Process Id as a GET to the [AtomSphere Component API](https://developer.boomi.com/api/platformapi#tag/Component)
7. With the output from Step 6, in a Text editor and replace the line `<processcall abort="true" processId="UUIDUsedInStep6" wait="true">` with `<processcall abort="true" processId="{1}" wait="true">`
8. Package and Deploy the process

### Testing
9. Call the API that was deployed as part of Step 8 with the Id of a Process that has a `Web Services Server` Start Shape
> {<br>
>&emsp;&emsp;"processId": "5b9cf704-3f42-4e40-b0fd-5027a400e90a"<br>
> }

You should get something similar to<br>
_Clone da3ba1f4-0f18-4b40-a149-9a54c01248b9 created from 5b9cf704-3f42-4e40-b0fd-5027a400e90a (Test Suite Id: 7)_

**Notice how the Process `(wsvc) 1. Test Controller` automatically updates to include your Process under test and that your Process has its Start shape updated to `Data Passthrough`**
