function fish_prompt
	test $SSH_TTY
    and printf (set_color red)(whoami)(set_color white)'@'(set_color yellow)(hostname)' '


	if git rev-parse ^/dev/null
		# Magenta if branch detached else green
		git branch -qv | grep "\*" | string match -rq detached
		and set_color brmagenta
		or set_color brgreen

		printf (git branch ^/dev/null | grep \* | sed 's/* //')' '

		for i in (git branch -qv --no-color|grep \*|cut -d' ' -f4-|cut -d] -f1|tr , \n)\
 (git status --porcelain | cut -c 1-2 | uniq)
            switch $i
                case "*[ahead *"
                    printf (set_color magenta)⬆' '
                case "*behind *"
                    printf (set_color magenta)⬇' '
                case "."
                    printf (set_color green)✚' '
                case " D"
                    printf (set_color red)✖' '
                case "*M*"
                    printf (set_color blue)✱' '
                case "*R*"
                    printf (set_color brmagenta)➜' '
                case "*U*"
                    printf (set_color bryellow)═' '
                case "??"
                    printf (set_color brwhite)◼' '
            end
        end
	end


    test $USER = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color cyan)(prompt_pwd) (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
    end


end
