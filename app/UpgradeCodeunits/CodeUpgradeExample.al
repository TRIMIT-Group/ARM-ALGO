// codeunit 50100 "CodeUpgradeExample_PTE"
// {
//     Subtype = Upgrade;

//     trigger OnUpgradePerCompany()
//     var
//         UpgradeTagMgt: Codeunit "Upgrade Tag";
//         UpgradeTagExample: Codeunit "UpgradeTagExample_PTE";
//     begin
//         // Check whether the tag has been used before, and if so, don't run upgrade code
//         if UpgradeTagMgt.HasUpgradeTag(UpgradeTagExample.GetABCShoeSizeUpgradeTag()) then
//             exit;

//         // Run upgrade code
//         UpgradeShoeSize();

//         // Insert the upgrade tag in table 9999 "Upgrade Tags" for future reference
//         UpgradeTagMgt.SetUpgradeTag(UpgradeTagExample.GetABCShoeSizeUpgradeTag());
//     end;

//     local procedure UpgradeShoeSize()
//     var
//         Customer: Record Customer;
//     begin

//         if not Customer.FindSet() then
//             exit;

//         repeat
//             // Make sure that target field is blank because you're copying obsolete=removed field to new field
//             // Additional safety check
//             if Customer."ABC - Customer Shoesize" <> 0 then
//                 Error('ShoeSize must be blank, the value is already assigned');

//             // Avoid blank modifies - it is a performance hit and slows down the upgrade
//             if Customer."ABC - Customer Shoesize" <> Customer.Shoesize then begin
//                 Customer."ABC - Customer Shoesize" := Customer.Shoesize;
//                 Customer.Modify();
//             end;
//         until Customer.Next() = 0;
//     end;
// }