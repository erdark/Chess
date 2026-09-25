Class {
	#name : 'MyQueen',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyQueen >> characterMap [
	^ Dictionary newFrom: { 
		(Color white -> Color white) -> 'Q' .
		(Color white -> Color black) -> 'q' .
		(Color black -> Color white) -> 'W' .
		(Color black -> Color black) -> 'w'
	}
]

{ #category : 'rendering' }
MyQueen >> renderPieceOn: aSquare [

	^ self characterMap at: (self color -> aSquare color)
]

{ #category : 'rendering' }
MyQueen >> targetSquaresLegal: aBoolean [

	| likeABishop likeARook |
	likeABishop := (self upRightDiagonalLegal: aBoolean)
	               , (self upLeftDiagonalLegal: aBoolean)
	               , (self downRightDiagonalLegal: aBoolean)
	               , (self downLeftDiagonalLegal: aBoolean).
	likeARook := (self upFileLegal: aBoolean)
	             , (self downFileLegal: aBoolean)
	             , (self leftFileLegal: aBoolean)
	             , (self rightFileLegal: aBoolean).
	^ likeABishop , likeARook
]
