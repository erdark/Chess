Class {
	#name : 'MyPawnTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTests >> testStartMovesTwoSquare [

	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	
	squares := pawn targetSquares.
	self
		assertCollection: squares 
		includesAll: 
			(#( e3 e4 ) collect: [ :name | board at: name ])
]

{ #category : 'tests' }
MyPawnTests >> testStartMovesWithOponentObstacle [

	| pawn squares board |
	board := MyChessBoard empty.
	board at: 'e2' put: (pawn := MyPawn white).
	
	board at: 'e4' put: MyPawn black.
	
	squares := pawn targetSquares.
	self
		assertCollection: squares 
		includesAll: 
			(#( e3 ) collect: [ :name | board at: name ])
]
