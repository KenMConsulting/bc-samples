codeunit 50800 CheckPermissions
{

    trigger OnRun()
    begin

    end;

    local procedure checkSuper()
    var
        UserPermissions: Codeunit "User Permissions";
    begin
        // Check if the current user has the SUPER permission set
        if not UserPermissions.IsSuper(UserSecurityId()) then
            Error('You do not have the required SUPER permission to access this page.');
    end;

    local procedure hasPermission(permSet: Code[20]): Boolean
    var
        UserPermissions: Codeunit "User Permissions";
        EmptyGuid: Guid;
    begin
        /* procedure HasUserPermissionSetAssigned(UserSecurityId: Guid; Company: Text; RoleId: Code[20]; Scope: Option; AppId: Guid): Boolean */

        //Assume permSet is PIAPPROVE
        // Check if the current user has the PIAPPROVE permission set
        exit(UserPermissions.HasUserPermissionSetAssigned(UserSecurityId(), CompanyName, permSet, 0, EmptyGuid))
    end;
}
