rules = ['aws_cli', 'git_checkout', 'git_push', 'no_command']
require_confirmation = True
wait_command = 10
no_colors = False
priority = {'aws_cli': 100, 'git_checkout': 100, 'git_push': 100, 'no_command': 9999}
