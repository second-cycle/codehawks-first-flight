## Summary

The vulnerability in this contract lies with the setPassword() function in PasswordStore.sol. The function, in its current state, allows any using to call the function and change the password to whatever they choose.

## Vulnerability Details

As stated in the summary the setPassword() function allows any user to set the password when the contract writers intention, as can be seen from the comments, intends for this function only to be called by the owner. This can be compared to the other function in the contract, getPassword(), which does have these protections allowing only the owner to call the function.

## Impact

The impact of the vulnerability is that the password is not secure. Although only the only can view the current password, any user can change the password, resulting in it being pretty much useless.  

## Tools Used

This vulnerability was discovered by inspecting the code itself and confirmed through writing tests in Foundry to check that the owner was able to call both functions and that the functions would revert when called by a user that was not the owner.

## Recommendations

The recommendation of this auditor is that the setPassword() function should contain the same conditional that the getPassword() contains in order to cause the function call to revert when called by a user that is not the owner.

A secondary measure can be taken which would require the owner to provide the previous password in order to set a new password as is common in most authentication frameworks.  
