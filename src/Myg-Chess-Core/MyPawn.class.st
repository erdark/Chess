Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [

	^ 'P'
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
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
