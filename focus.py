#!/usr/bin/env python3

import i3ipc

i3 = i3ipc.Connection()

# searches for <con> in <tree>, returns True if <con> is floating
def find_floating(tree, con):
    for c in tree.descendents():
        for f_nodes in c.floating_nodes:
            for node in f_nodes.nodes:
                if node == con:
                    return True 
    return False

def find_tmp(ws):
    tmp = None
    for c in ws.descendents():
        if c.nodes == [] and c.window == None and c.name == None and c.type == "con":
            tmp = c
    return tmp

def create_tmp(current):
    current.command('splitv')
    current.command('open')

def destroy_tmp(tmp):
    tmp.command('kill')

def make_float(current):
    current.command('floating enable')
    current.command('resize set 1000 1000')
    current.command('move position center')
    current.command('focus')

def make_unfloat(current):
    current.command('floating disable')
    current.command('focus')

def main():
    tree = i3.get_tree()
    current = tree.find_focused()
    ws = current.workspace()

    if find_floating(tree, current):
        make_unfloat(current)
        tmp = find_tmp(ws)
        if tmp != None:
            destroy_tmp(tmp)
    else:
        if find_tmp(ws) == None:
            create_tmp(current)
            make_float(current)

main()
