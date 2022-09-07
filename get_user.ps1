param( [ Parameter(Mandatory=$true) ] $JSONFile )

function CreateADGroup(){
    param( [ Parameter(Mandatory=$true) ] $groupObject )
    $name = $groupObject.name
    New-ADGroup -name $name -GroupScope Global
}


function CreateADUser(){
    param( [ Parameter(Mandatory=$true) ] $userObject ) 

    # Pull the name from the JSON Object
    $name = $userObject.name
    $password = $userObject.password

    # Generate a first intial last name structure for username
    $firstname, $lastname = $name.Split(" ")
    $username = ($firstname[0] + $lastname).ToLower()
    $SamAccountName = $username
    $principalname = $username

    
    # create user AD object
    New-ADUser -Name "$name" -GivenName $firstname -Surname $lastname -SamAccountName $SamAccountName -UserPrincipalName $principalname@$Global:Domain -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -PassThru | Enable-ADAccount


    # Add users to their group appropriately
    foreach($group_name in $userObject.groups) {

        try {
            Get-ADGroup -Identity "$group_name"
            Add-ADGroupMember -Identity $group_name -Members $username
        }
            catch [Microsoft.ActiveDirectory.Management.ADIdentityNotFoundExceptio]
            {
                Write-Warning "User $user NOT added to group $group_name because it does not exist!"
            }
    }

}

$json = (Get-Content $JSONFile | ConvertFrom-Json)

$Global:Domain = $json.domain

foreach ($group in $json.groups){
    CreateADGroup $group
}

foreach ($user in $json.users){
    CreateADUser $user
}




