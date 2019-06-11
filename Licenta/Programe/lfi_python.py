from problog.logic import Term
from problog.program import PrologString
from problog.learning import lfi

model = """
t(_)::cutremur.
t(_)::tsunami.
t(_)::uragan.

casaDaramata :- cutremur.
casaDaramata :- tsunami.
casaDaramata :- uragan.
"""

cutremur = Term('cutremur')
tsunami = Term('tsunami')
uragan = Term('uragan')
casaDaramata = Term('casaDaramata')

interpretari = [
    [(cutremur, False), (tsunami, False), (alarm, False)],
    [(cutremur, False), (tsunami, False), (alarm, True)],
    [(cutremur, True), (uragan, True), alarm(True)],
    [(cutremur, False), (tsunami, False), (uragan, True), (alarm, True)],
    [(cutremur, False), (tsunami, False), (uragan, True), (alarm, True)],
    [(cutremur, False), (tsunami, True), (uragan, True), (alarm, True)],
]

score, weights, atoms, iteration, lfi_problem = lfi.run_lfi(PrologString(model), interpretari)

print (lfi_problem.get_model())
