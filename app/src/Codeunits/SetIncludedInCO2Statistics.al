codeunit 50000 "SetIncludedInCO2Statistics_PTE"
{
    // This code is created as an example and must be removed before deploying. #TODO
    internal procedure SetIncludedInCO2Statistics(var Customer: Record Customer; xCustomer: Record Customer)
    var
        IsHandled: Boolean;
    begin
        OnBeforeSetIncludedInCO2Statistics(Customer, xCustomer, IsHandled);

        DoSetIncludedInCO2Statistics(Customer, xCustomer, IsHandled);

        OnAfterSetIncludedInCO2Statistics(Customer, xCustomer);
    end;

    local procedure DoSetIncludedInCO2Statistics(var Customer: Record Customer; xCustomer: Record Customer; IsHandled: Boolean)
    var
        ConfirmManagement: Codeunit "Confirm Management";
        CustomerIncludedLbl: Label 'The Customer will now be included in the CO2 statistics', Comment = 'DAN="Kunden vil nu blive inkluderet i CO2-forbrugsstatistikken."';
        IncludeCustomerQstLbl: Label 'Are you sure that the Customer: %1 should be included in the CO2 consumption statistics?', Comment = 'DAN="Er du sikker på at kunden: %1 skal inkluderes i CO2-forbrugsstatistikken?"';
    begin
        if IsHandled then
            exit;

        if xCustomer."Include in CO2 Statistics_PTE" then
            exit;

        if not ConfirmManagement.GetResponse(StrSubstNo(IncludeCustomerQstLbl, Customer.Name)) then
            exit;

        if not Customer."Include in CO2 Statistics_PTE" then
            exit;

        Message(CustomerIncludedLbl);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeSetIncludedInCO2Statistics(var Customer: Record Customer; xCustomer: Record Customer; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterSetIncludedInCO2Statistics(var Customer: Record Customer; xCustomer: Record Customer)
    begin
    end;
}