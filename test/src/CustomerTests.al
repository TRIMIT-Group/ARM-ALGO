codeunit 80501 "Customer Tests_TPTE"
{
    Subtype = Test;
    // This test and the code added to the app is created as an example and must be removed before deploying. #TODO

    [Test]
    [HandlerFunctions('MessageHandler,ConfirmHandler')]
    procedure "When Customer CO2 Usage is validated, Include in CO2 Statistics state should change"()
    var
        Customer: Record Customer;
    begin
        Initialize();
        // [GIVEN] Customer Created
        LibrarySales.CreateCustomer(Customer);

        // [WHEN] When CO2 usage is validated with a value different than 0
        Customer.Validate("CO2 Usage_PTE", 1);

        // [THEN] Then Include in CO2 Statistics should be set to true
        LibraryAssert.IsTrue(Customer."Include in CO2 Statistics_PTE", 'Included in CO2 Statistics should have been set to true.');
    end;

    [Test]
    [HandlerFunctions('MessageHandler,IncludeInCO2StatisticsConfirmHandler')]
    procedure "When Include in CO2 Statistics is set to true the user should be prompted to confirm"()
    var
        Customer: Record Customer;
        CustomerQstLbl: Label 'Are you sure that the Customer: %1 should be included in the CO2 consumption statistics?', Locked = true;
        ExpectedMessage: Variant;
    begin
        Initialize();
        // [GIVEN] Customer Created
        LibrarySales.CreateCustomer(Customer);

        // [WHEN] When Include in CO2 Statistics is set to true
        Customer.Validate("Include in CO2 Statistics_PTE", true);

        // [THEN] Then the user should be prompted to confirm
        LibraryVariableStorage.Dequeue(ExpectedMessage);
        LibraryAssert.ExpectedMessage(StrSubstNo(CustomerQstLbl, Customer.Name), Format(ExpectedMessage));
    end;

    local procedure Initialize()
    var
        LibraryLowerPermissions: Codeunit "Library - Lower Permissions";
    begin
        // Add code that needs to be repeated for every test run

        LibraryLowerPermissions.AddPermissionSet('SUPER');

        if IsInitialized then
            exit;

        // Add code that needs to be repeated for every test suite run

        IsInitialized := true;
    end;

    [MessageHandler]
    procedure MessageHandler(MessageText: Text[1024])
    begin

    end;

    [ConfirmHandler]
    procedure ConfirmHandler(Question: Text[1024]; var Reply: Boolean)
    begin
        Reply := true;
    end;

    [ConfirmHandler]
    procedure IncludeInCO2StatisticsConfirmHandler(Question: Text[1024]; var Reply: Boolean)
    begin
        LibraryVariableStorage.Enqueue(Question);
        Reply := true;
    end;

    var
        LibrarySales: Codeunit "Library - Sales";
        LibraryVariableStorage: Codeunit "Library - Variable Storage";
        LibraryAssert: Codeunit "Library Assert";
        IsInitialized: Boolean;
}