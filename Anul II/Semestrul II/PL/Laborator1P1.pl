male(rickard_stark).
male(eddard_stark).
male(brandon_stark).
male(benjen_stark).
male(robb_stark).
male(bran_stark).
male(rickon_stark).
male(jon_snow).
male(aerys_targaryen).
male(rhaegar_targaryen).
male(viserys_targaryen).
male(aegon_targaryen).

female(lyarra_stark).
female(catelyn_stark).
female(lyanna_stark).
female(sansa_stark).
female(arya_stark).
female(rhaella_targaryen).
female(elia_targaryen).
female(daenerys_targaryen).
female(rhaenys_targaryen).

parent_of(rickard_stark, eddard_stark).
parent_of(rickard_stark, brandon_stark).
parent_of(rickard_stark, benjen_stark).
parent_of(rickard_stark, lyanna_stark).
parent_of(lyarra_stark, eddard_stark).
parent_of(lyarra_stark, brandon_stark).
parent_of(lyarra_stark, benjen_stark).
parent_of(lyarra_stark, lyanna_stark).
parent_of(catelyn_stark, robb_stark).
parent_of(catelyn_stark, sansa_stark).
parent_of(catelyn_stark, arya_stark).
parent_of(catelyn_stark, bran_stark).
parent_of(catelyn_stark, rickon_stark).
parent_of(eddard_stark, robb_stark).
parent_of(eddard_stark, sansa_stark).
parent_of(eddard_stark, arya_stark).
parent_of(eddard_stark, bran_stark).
parent_of(eddard_stark, rickon_stark).
parent_of(lyanna_stark, jon_snow).
parent_of(rhaegar_targaryen, jon_snow).
parent_of(aerys_targaryen, rhaegar_targaryen).
parent_of(aerys_targaryen, viserys_targaryen).
parent_of(aerys_targaryen, daenerys_targaryen).
parent_of(rhaella_targaryen, rhaegar_targaryen).
parent_of(rhaella_targaryen, viserys_targaryen).
parent_of(rhaella_targaryen, daenerys_targaryen).
parent_of(rhaegar_targaryen, rhaenys_targaryen).
parent_of(rhaegar_targaryen, aegon_targaryen).
parent_of(elia_targaryen, rhaenys_targaryen).
parent_of(elia_targaryen, aegon_targaryen).

father_of(Father, Child) :- male(Father), parent_of(Father, Child).
mother_of(Mother, Child) :- female(Mother), parent_of(Mother, Child).
grandfather_of(Grandfather, Child) :- male(Grandfather), parent_of(Grandfather, Father), parent_of(Father, Child).
grandmother_of(Grandmother, Child) :- female(Grandmother), parent_of(Grandmother, Mother), parent_of(Mother, Child).
sister_of(Sister, Person) :- female(Sister), parent_of(Parent, Sister), parent_of(Parent, Person), Sister\==Person.
brother_of(Brother, Person) :- male(Brother), parent_of(Parent, Brother), parent_of(Parent, Person), Brother\==Person.
aunt_of(Aunt, Person) :- female(Aunt), parent_of(Parent, Person), sister_of(Aunt, Parent).
uncle_of(Uncle, Person) :- male(Uncle), parent_of(Parent, Person), brother_of(Uncle, Parent).








