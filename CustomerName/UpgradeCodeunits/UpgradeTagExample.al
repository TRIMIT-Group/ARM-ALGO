// codeunit 50101 "UpgradeTagExample_PTE"
// {
//     // Register the new upgrade tag for new companies when they are created.
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Upgrade Tag", 'OnGetPerCompanyUpgradeTags', '', false, false)]
//     local procedure OnGetPerCompanyTags(var PerCompanyUpgradeTags: List of [Code[250]])
//     begin
//         PerCompanyUpgradeTags.Add(GetABCShoeSizeUpgradeTag());
//     end;

//     // Use methods to avoid hard-coding the tags. It is easy to remove afterwards because it's compiler-driven.
//     procedure GetABCShoeSizeUpgradeTag(): Text
//     begin
//         exit('ABC-1234-ShoeSizeUpgrade-20201125');
//     end;
// }