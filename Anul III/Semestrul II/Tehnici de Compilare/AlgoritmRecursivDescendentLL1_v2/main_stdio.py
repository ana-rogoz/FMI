#!/usr/bin/python3
'''
Format fisier de intrare: 
N = {multime neterminale separate prin spatiu}
Sigma = {multime terminale separate prin spatiu} (inclusiv $ si l)
S = {simbolul de start}
productia1
productia2
...
productia3
(fiecare de forma X -> x)
'''
import argparse
import sys

def citire(f):
    gramatica = {
        'N': [],
        'Sigma': [],
        'S': 'S',
        'P': [] 
    }
    for i in range(3):
        line = f.readline()
        line = line.rstrip()

        idx = line.find(' = ')
        s = line[:idx]
        elements = line[idx+3:].split(' ')
        gramatica[s] = elements
        if s == 'S':
            gramatica[s] = elements[0]
    for line in f:
        line = line.rstrip()

        idx = line.find(' -> ')
        left_hand_side = line[:idx]
        right_hand_side = line[idx+4:]
        gramatica['P'].append((left_hand_side, right_hand_side))
    return gramatica


def calculeaza_first_follow(gramatica):
    first = {}
    follow = {}
    for terminal in gramatica['Sigma']:
        first[terminal] = {terminal}
        follow[terminal] = set()

    for neterminal in gramatica['N']:
        first[neterminal] = set()
        follow[neterminal] = set()
        
    follow[gramatica['S']].add('$')
    neterminali_lambda = set()
    for left, right in gramatica['P']:
        if right == 'l':
            neterminali_lambda.add(left)
    ok = True
    while ok == True:
        ok = False

        for left, right in gramatica['P']:
            for symbol in right:
                ok |= reuniune(first[left], first[symbol])
                if symbol not in neterminali_lambda:
                    break
                else:
                    ok |= reuniune(neterminali_lambda, {left})

            new = follow[left]
            for symbol in reversed(right):
                ok |= reuniune(follow[symbol], new)
                if symbol in neterminali_lambda:
                    new = new.union(first[symbol])
                else:
                    new = first[symbol]
    return first, follow


def reuniune(first, begins):
    n = len(first)
    first |= begins
    return len(first) != n


def make_csting(l):
   cstring = 'string(\"'
   for elem in l:
       cstring += elem
   cstring += '\")'
   return cstring
   

def main():
    parser = argparse.ArgumentParser(description='Algoritm recursiv descendent.')
    parser.add_argument('input', type=str, help='Fisierul de intrare.')
    parser.add_argument('output', type=str, help='Fisierul de iesire.')

    args = parser.parse_args()
    inputFile = args.input
    outputFile = args.output

    inf = open(inputFile, 'r')
    gramatica = citire(inf)
    inf.close()
    first, follow = calculeaza_first_follow(gramatica)

    out = open(outputFile, 'w')
    # include libraries
    out.write('#include <iostream>\n')
    out.write('#include <string>\n')
    out.write('#include <cstdio>\n')
    out.write('\n')

    out.write('using namespace std;')
    out.write('\n')
    # global variables
    out.write('string s;\n')
    out.write('int i = -1;\n')
    out.write('char token;\n')
    out.write('\n')

    for neterminal in gramatica['N']:
        out.write('void ' + neterminal + '();\n')
    out.write('void check(string alpha);\n')
    out.write('void parse_neterminal(string alpha);\n')
    out.write('\n')

    # first functions
    out.write('string first(char c) {\n')
    out.write('  switch(c) {\n')
    for terminal in gramatica['Sigma']:
        out.write('    case \'' + terminal + '\': return ' + make_csting(first[terminal]) + '; break;\n')
    for neterminal in gramatica['N']:
        out.write('    case \'' + neterminal + '\': return ' + make_csting(first[neterminal]) + '; break;\n')
    out.write('  }\n')
    out.write('}\n')
    out.write('\n')

    # follow functions
    out.write('string follow(char c) {\n')
    out.write('  switch(c) {\n')
    for terminal in gramatica['Sigma']:
        out.write('    case \'' + terminal + '\': return ' + make_csting(follow[terminal]) + '; break;\n')
    for nonterminal in gramatica['N']:
        out.write('    case \'' + nonterminal + '\': return ' + make_csting(follow[nonterminal]) + '; break;\n')
    out.write('  }\n')
    out.write('}\n')
    out.write('\n')

    # scan function which returns next token
    out.write('char scan() {\n')
    out.write('  ++i;\n')
    out.write('  if (i < s.size()) {\n')
    out.write('    return s[i];\n')
    out.write('  }\n')
    out.write('  return 0;\n')
    out.write('}\n')
    out.write('\n')

    # check function
    out.write('void check_terminal(string alpha) {\n')
    out.write('  if (alpha[0] == token) {\n')
    out.write('    token = scan();\n')
    out.write('  }\n')
    out.write('  else {\n')
    out.write('    cout << alpha[0] + \" expected\\n\";\n')
    out.write('  }\n')
    out.write('  if (alpha.size() >= 2) {\n')
    out.write('    check(alpha.substr(1));\n')
    out.write('  }\n')
    out.write('}\n')
    out.write('\n')

    out.write('void check_nonterminal(string alpha) {\n')
    out.write('  parse_neterminal(alpha);\n')
    out.write('}\n')
    out.write('\n')

    out.write('void check(string alpha) {\n')
    out.write('  switch(alpha[0]) {\n')
    for terminal in gramatica['Sigma']:
        out.write('    case \'' + terminal + '\': check_terminal(alpha); break;\n')
    for neterminal in gramatica['N']:
        out.write('    case \'' + neterminal + '\': check_nonterminal(alpha); break;\n')
    out.write('  }\n')
    out.write('}\n')
    out.write('\n')

    # parse function for terminals and nonterminals
    out.write('void parse_terminal(string alpha) {\n')
    out.write('  if (alpha[0] != \'l\') {\n')
    out.write('    token = scan();\n')
    out.write('  }\n')
    out.write('  if (alpha.size() >= 2) {\n')
    out.write('    check(alpha.substr(1));\n')
    out.write('  }\n')
    out.write('}\n')
    out.write('\n')
    out.write('void parse_neterminal(string alpha) {\n')
    out.write('  switch(alpha[0]) {\n')
    for neterminal in gramatica['N']:
        out.write('    case \'' + neterminal + '\':' + neterminal + '(); break;\n')
    out.write('  }\n')
    out.write('  if (alpha.size() >= 2) {\n')
    out.write('    check(alpha.substr(1));\n')
    out.write('  }\n')
    out.write('}\n')
    out.write('\n')

    # function for every nonterminal A from N
    for neterminal in gramatica['N']:
        out.write('void ' + neterminal + '() {\n')
        for left, right in gramatica['P']:
            if left == neterminal:
                if right[0] != 'l':
                    out.write('  if (first(\'' + right[0] + '\').find(token) != string::npos) {\n')
                    out.write('    cout << \"' + neterminal + ' -> ' + right + '\\n\";\n')
                    if right[0] in gramatica['N']:
                        out.write('    parse_neterminal(\"' + right + '\");\n')
                    else:
                        out.write('    parse_terminal(\"' + right + '\");\n')
                    out.write('    return;\n')
                    out.write('  }\n')
                else:
                    out.write('  if (follow(\'' + left + '\').find(token) != string::npos) {\n')
                    out.write('    cout << \"' + neterminal + ' -> ' + right + '\\n\";\n')
                    if right[0] in gramatica['N']:
                        out.write('    parse_neterminal(\"' + right + '\");\n')
                    else:
                        out.write('    parse_terminal(\"' + right + '\");\n')
                    out.write('    return;\n')
                    out.write('  }\n')

        out.write('  cout << \"Se asteapta un token diferit\\n\";\n')
        out.write('}\n')
        out.write('\n')

    out.write('int main() {\n')
    out.write('  cin >> s;\n')
    out.write('  token = scan();\n')
    out.write('  ' + gramatica['S'] + '();\n')
    out.write('  if (token != 0) {\n')
    out.write("      cout << \"ERROR: EOF expectd\\n\";\n")
    out.write('  }\n')
    out.write('  return 0;\n')
    out.write('}\n')

if __name__ == '__main__':
    sys.exit(main());
