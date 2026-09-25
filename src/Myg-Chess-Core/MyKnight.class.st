Class {
	#name : 'MyKnight',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyKnight >> characterMap [
	^ Dictionary newFrom: { 
		(Color white -> Color white) -> 'N' .
		(Color white -> Color black) -> 'n' .
		(Color black -> Color white) -> 'M' .
		(Color black -> Color black) -> 'm'
	}
]

{ #category : 'accessing' }
MyKnight >> id [
	
	^ 'N'
]

{ #category : 'rendering' }
MyKnight >> renderPieceOn: aSquare [

	^ self characterMap at: (self color -> aSquare color)
]

{ #category : 'rendering' }
MyKnight >> targetSquaresLegal: aBoolean [

	^ {
		  (square right ifNotNil: [ :p | p right ifNotNil: #up ]).
		  (square right ifNotNil: [ :p | p right ifNotNil: #down ]).
		  (square left ifNotNil: [ :p | p left ifNotNil: #up ]).
		  (square left ifNotNil: [ :p | p left ifNotNil: #down ]).
		  (square up ifNotNil: [ :p | p up ifNotNil: #left ]).
		  (square up ifNotNil: [ :p | p up ifNotNil: #right ]).
		  (square down ifNotNil: [ :p | p down ifNotNil: #left ]).
		  (square down ifNotNil: [ :p | p down ifNotNil: #right ]) }
		  select: [ :s |
			  s notNil and: [ s hasPiece not or: [ s contents color ~= color ] ] ]
]
