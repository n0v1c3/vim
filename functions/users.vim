" Name: users.vim
" Description: 
" Authors: Travis Gall
" Notes:

" Get a string input from the user
function! UserInput(prompt)
    " Get input from user
    call inputsave()
    let reply=input(a:prompt)
    call inputrestore()
    
    " Return the user's reply
    return l:reply
endfunction
