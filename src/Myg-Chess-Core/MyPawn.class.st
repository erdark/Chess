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

	| oneStep twoStep |
	oneStep := self isWhite
		ifTrue: [ square up ]
		ifFalse: [ square down ].

	twoStep := self isWhite
		ifTrue: [ oneStep ifNotNil: [ oneStep up ] ]
		ifFalse: [ oneStep ifNotNil: [ oneStep down ] ].

	^ {
		oneStep.
		(( isMove = false )
			and: [ oneStep notNil
			and: [ oneStep hasPiece not
			and: [ twoStep notNil
			and: [ twoStep hasPiece not ] ] ]])
			ifTrue: [ twoStep ]
			ifFalse: [ nil ]
		}
		select: [ :s | s notNil and: [ s hasPiece not ] ]
]
