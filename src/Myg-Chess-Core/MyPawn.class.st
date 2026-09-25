Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> characterMap [
	^ Dictionary newFrom: { 
		(Color white -> Color white) -> 'P' .
		(Color white -> Color black) -> 'p' .
		(Color black -> Color white) -> 'O' .
		(Color black -> Color black) -> 'o'
	}
]

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [ 

	| previousSquare distance isEnPassantCapture |
	previousSquare := square.
	
	isEnPassantCapture := (aSquare file ~= previousSquare file) 
		and: [ aSquare column ~= previousSquare column 
		and: [ aSquare hasPiece not ] ].

	super moveTo: aSquare.

	isEnPassantCapture ifTrue: [
		(self isWhite ifTrue: [ aSquare down ] ifFalse: [ aSquare up ]) emptyContents
	].

	distance := (aSquare file asciiValue - previousSquare file asciiValue) abs.
	distance = 2 ifTrue: [
		self board enPassantSquare: (self isWhite 
			ifTrue: [ previousSquare up ] 
			ifFalse: [ previousSquare down ])
	] ifFalse: [
		self board enPassantSquare: nil
	].
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [
	^ self characterMap at: (self color -> aSquare color)
]

{ #category : 'rendering' }
MyPawn >> targetSquaresLegal: aBoolean [

	| oneStep twoStep diagLeft diagRight targets|
	oneStep := self isWhite
		ifTrue: [ square up ]
		ifFalse: [ square down ].

	twoStep := self isWhite
		ifTrue: [ oneStep ifNotNil: [ oneStep up ] ]
		ifFalse: [ oneStep ifNotNil: [ oneStep down ] ].
		
	diagLeft := oneStep ifNotNil: [ oneStep left ].
	diagRight := oneStep ifNotNil: [ oneStep right ].

	targets := OrderedCollection new.

	(oneStep notNil and: [ oneStep hasPiece not ]) ifTrue: [
		targets add: oneStep.
		((isMove isNil or: [ isMove = false ])
			and: [ twoStep notNil
			and: [ twoStep hasPiece not ] ])
			ifTrue: [ targets add: twoStep ]
	].

	{ diagLeft . diagRight } do: [ :diag |
		diag ifNotNil: [
			(diag hasPiece and: [ diag contents color ~= self color ]) ifTrue: [
				targets add: diag.
			].
			(self board enPassantSquare = diag) ifTrue: [
				targets add: diag.
			]
		]
	].

	^ targets select: [ :s | s notNil ]

	
]
