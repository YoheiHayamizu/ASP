#!/usr/bin/python
import subprocess
import re
import os
import sys


def sort_tasks(current_task):
    return current_task[0]


DIR_NAME_BASE = os.path.dirname(__file__)
# DIR_NAME_ASP = os.path.abspath(DIR_NAME_BASE + "./../asp_navigation")
DIR_NAME_ASP = os.path.abspath(DIR_NAME_BASE + "./../asp_navigation_hard")
DIR_NAME_PY = os.path.abspath(DIR_NAME_BASE + "./../asp2py")
filename = DIR_NAME_ASP + "/query.asp"
SOLVER = "clingo "
OPTION_STEP = lambda x: "-c n={0} ".format(x)
OPTION_ANS = "-n 0 "
OPTION_FILES = DIR_NAME_ASP + "/*.asp " + DIR_NAME_ASP + "/cost.lua "
OPTION_MINIMIZE = "--opt-mode=optN"
TOLERANCE = 1.


# print(DIR_NAME_BASE)
# print(DIR_NAME_ASP)
# print(DIR_NAME_PY)


def parse_plans(output):
    lines = str(output).split("\\n")

    plans_list = []
    total_cost_list = []
    for i, line in enumerate(lines):
        # print(line)
        if line.find("Answer") != -1:
            plans_list.append(lines[i + 1])
        if line.find("Optimization") != -1:
            tmp = line.split(" ")
            total_cost_list.append(int(tmp[-1]))

    plans_group = list()
    for plan_list in plans_list:
        plan = plan_list.split()
        at_list = []
        action_list = []
        hasdoor_list = []
        opendoor_list = []
        cost_dict = {}
        for p in plan:
            prefix = p[:p.find("(")]
            location_step_pair = p[p.find("(") + 1:p.find(")")]
            tmp = location_step_pair.split(",")
            if prefix == "at":
                at_list.append([prefix] + tmp)
            elif prefix == "hasdoor":
                hasdoor_list.append([prefix] + tmp)
            elif prefix == "open":
                opendoor_list.append([prefix] + tmp)
            elif prefix == "cost":
                cost_dict[tuple([prefix] + tmp[:-1])] = tmp[-1]
            else:
                action_list.append([prefix] + tmp)
        # print(at_list)
        # print(action_list)
        # print(hasdoor_list)
        # print(opendoor_list)
        # print(cost_dict)

        location_group = []
        for _, s, t in at_list[:-1]:
            location = list()
            i = int(t)
            """
                location: [timestep, state, door, door_state, action, next_state, next_door, next_door_state]
            """
            location.append(i)
            location.append(s)
            location.append(None)
            for d in hasdoor_list:
                if d[1] == at_list[i][1]:
                    location[-1] = d[2]
                    break
            if ['open', location[-1], str(location[0])] in opendoor_list:
                location.append(True)
            else:
                location.append(False)
            for a in action_list:
                if a[2] == t:
                    location.append(a[0])
                    break
            location.append(at_list[i + 1][1])
            location.append(None)
            for d in hasdoor_list:
                if d[1] == at_list[i + 1][1]:
                    location[-1] = d[2]
                    break
            if ['open', location[-1], str(location[0] + 1)] in opendoor_list:
                location.append(True)
            else:
                location.append(False)
            if ('cost', location[1], location[5]) in cost_dict.keys():
                location.append(cost_dict[('cost', location[1], location[5])])

            location_group.append(location)
        location_group.sort(key=sort_tasks)
        plans_group.append(location_group)

    return plans_group


def find_plan(init_state, goal_state):
    # Make file which plans paths.
    initial_at = "at(" + init_state + ", 0)."

    final_at = "\n:- not at(" + goal_state + ", n-1)."

    show_text = """     
                    \n#minimize { L,X,Y,I: path(X,Y,I), cost(X,Y,L)}.
                    \n#show approach/2.
                    \n#show gothrough/2.
                    \n#show opendoor/2.
                    \n#show goto/2.
                    \n#show at/2.
                    \n#show hasdoor/2.
                    \n#show open/2.
                    \n#show cost/3.
                    \n%#show path/3.
                    \n%#show beside/2.
                    \n%#show facing/2.
                """

    query2 = initial_at + final_at + show_text
    f = open(filename, "w")
    f.write(query2)
    f.close()

    # Parse the output from clingo
    output = "UNSATISFIABLE"
    i = 0
    while "UNSATISFIABLE" in str(output):
        if (i > 20):
            sys.exit()
        i = i + 1
        # print(SOLVER + OPTION_STEP(i) + OPTION_ANS + OPTION_FILES + OPTION_MINIMIZE)
        p = subprocess.Popen(SOLVER + OPTION_STEP(i) + OPTION_ANS + OPTION_FILES + OPTION_MINIMIZE,
                             stdout=subprocess.PIPE, shell=True)
        (output, err) = p.communicate()
        p.wait()

    minimal_step = i
    torelance = minimal_step * TOLERANCE

    plan_T_step_list = list()
    for j in range(int(torelance) + 1):
        p = subprocess.Popen(SOLVER + OPTION_STEP(j) + OPTION_ANS + OPTION_FILES + OPTION_MINIMIZE,
                             stdout=subprocess.PIPE, shell=True)
        (output, err) = p.communicate()
        p.wait()
        cost_plan_list = parse_plans(output)
        if len(cost_plan_list) == 0:
            continue
        for i in cost_plan_list:
            plan_T_step_list.append(i)
    # plan_T_step_list.sort(key=sort_tasks, reverse=True)
    # print(plan_T_step_list)
    # plan_T_step_list.sort(key=sort_tasks)
    # print(plan_T_step_list)
    return plan_T_step_list


if __name__ == '__main__':
    # if len(sys.argv) != 3:
    #     raise Exception("input init_state, final_goal")

    test = find_plan("s0", "s14")
    print(test)
    num = 0
    for j in test:
        print(j)
        num += 1
        # break
    print(num)

