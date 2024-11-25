// codeunit 80500 "InstallALTestSuite_TPTE"
// {
//     Subtype = Install;

//     trigger OnInstallAppPerCompany()
//     var
//         MyObject: Record AllObjWithCaption;
//         TestSuite: Record "AL Test Suite";
//         TestSuiteMgt: Codeunit "Test Suite Mgt.";
//         TestSuiteName: Code[10];
//     begin
//         TestSuiteName := 'TRM Test';

//         // First, create a new Test Suite
//         if TestSuite.Get(TestSuiteName) then
//             TestSuiteMgt.DeleteAllMethods(TestSuite)
//         else begin
//             TestSuiteMgt.CreateTestSuite(TestSuiteName);
//             TestSuite.Get(TestSuiteName);
//         end;

//         // Second, pull in the test codeunits
//         MyObject.SetRange("Object Type", MyObject."Object Type"::Codeunit);
//         MyObject.SetFilter("Object ID", '80500..80649');
//         MyObject.SetRange("Object Subtype", 'Test');

//         if MyObject.FindSet() then
//             repeat
//                 TestSuiteMgt.GetTestMethods(TestSuite, MyObject);
//             until MyObject.Next() = 0;

//         // Third, run the tests. This is of course an optional step
//         // TestMethodLine.SetRange("Test Suite", TestSuiteName);
//         // TestSuiteMgt.RunSelectedTests(TestMethodLine);
//     end;
// }