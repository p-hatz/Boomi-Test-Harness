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
   * `dppProdIdController` to the UUID of `(wsvc) 1. Test Controller` <br>
   <br>
    
