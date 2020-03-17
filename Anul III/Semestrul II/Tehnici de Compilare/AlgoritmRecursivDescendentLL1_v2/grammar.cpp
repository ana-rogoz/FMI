#include <iostream>
#include <string>
#include <cstdio>

using namespace std;
string s;
int i = -1;
char token;

void E();
void T();
void R();
void S();
void check(string alpha);
void parse_neterminal(string alpha);

string first(char c) {
  switch(c) {
    case '$': return string("$"); break;
    case '+': return string("+"); break;
    case '-': return string("-"); break;
    case '*': return string("*"); break;
    case 'l': return string("l"); break;
    case '(': return string("("); break;
    case ')': return string(")"); break;
    case 'n': return string("n"); break;
    case 'E': return string("(n"); break;
    case 'T': return string("(n"); break;
    case 'R': return string("-l+*"); break;
    case 'S': return string("(n"); break;
  }
}

string follow(char c) {
  switch(c) {
    case '$': return string("$"); break;
    case '+': return string("(n"); break;
    case '-': return string("(n"); break;
    case '*': return string("(n"); break;
    case 'l': return string("$)"); break;
    case '(': return string("(n"); break;
    case ')': return string("*l+-$)"); break;
    case 'n': return string("*l+-$)"); break;
    case 'E': return string("$)"); break;
    case 'T': return string("*l+-$)"); break;
    case 'R': return string("$)"); break;
    case 'S': return string("$"); break;
  }
}

char scan() {
  ++i;
  if (i < s.size()) {
    return s[i];
  }
  return 0;
}

void check_terminal(string alpha) {
  if (alpha[0] == token) {
    token = scan();
  }
  else {
    cout << alpha[0] + " expected\n";
  }
  if (alpha.size() >= 2) {
    check(alpha.substr(1));
  }
}

void check_nonterminal(string alpha) {
  parse_neterminal(alpha);
}

void check(string alpha) {
  switch(alpha[0]) {
    case '$': check_terminal(alpha); break;
    case '+': check_terminal(alpha); break;
    case '-': check_terminal(alpha); break;
    case '*': check_terminal(alpha); break;
    case 'l': check_terminal(alpha); break;
    case '(': check_terminal(alpha); break;
    case ')': check_terminal(alpha); break;
    case 'n': check_terminal(alpha); break;
    case 'E': check_nonterminal(alpha); break;
    case 'T': check_nonterminal(alpha); break;
    case 'R': check_nonterminal(alpha); break;
    case 'S': check_nonterminal(alpha); break;
  }
}

void parse_terminal(string alpha) {
  if (alpha[0] != 'l') {
    token = scan();
  }
  if (alpha.size() >= 2) {
    check(alpha.substr(1));
  }
}

void parse_neterminal(string alpha) {
  switch(alpha[0]) {
    case 'E':E(); break;
    case 'T':T(); break;
    case 'R':R(); break;
    case 'S':S(); break;
  }
  if (alpha.size() >= 2) {
    check(alpha.substr(1));
  }
}

void E() {
  if (first('T').find(token) != string::npos) {
    cout << "E -> TR\n";
    parse_neterminal("TR");
    return;
  }
  cout << "Se asteapta un token diferit\n";
}

void T() {
  if (first('(').find(token) != string::npos) {
    cout << "T -> (E)\n";
    parse_terminal("(E)");
    return;
  }
  if (first('n').find(token) != string::npos) {
    cout << "T -> n\n";
    parse_terminal("n");
    return;
  }
  cout << "Se asteapta un token diferit\n";
}

void R() {
  if (first('+').find(token) != string::npos) {
    cout << "R -> +TR\n";
    parse_terminal("+TR");
    return;
  }
  if (first('-').find(token) != string::npos) {
    cout << "R -> -TR\n";
    parse_terminal("-TR");
    return;
  }
  if (first('*').find(token) != string::npos) {
    cout << "R -> *TR\n";
    parse_terminal("*TR");
    return;
  }
  if (follow('R').find(token) != string::npos) {
    cout << "R -> l\n";
    parse_terminal("l");
    return;
  }
  cout << "Se asteapta un token diferit\n";
}

void S() {
  if (first('E').find(token) != string::npos) {
    cout << "S -> E$\n";
    parse_neterminal("E$");
    return;
  }
  cout << "Se asteapta un token diferit\n";
}

int main() {
  cin >> s;
  token = scan();
  S();
  if (token != 0) {
      cout << "ERROR: EOF expectd\n";
  }
  return 0;
}
