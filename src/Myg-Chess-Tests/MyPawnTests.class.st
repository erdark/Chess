Class {
	#name : 'MyPawnTests',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTests >> testEnPassant [

	| pawn pawn2 squares board |
	board := MyChessBoard empty.
	board at: 'e5' put: (pawn := MyPawn white).
	
	board at: 'd7' put: (pawn2 := MyPawn black).
	
	pawn2 moveTo: (board at: 'd5').
	
	squares := pawn targetSquares.
	self
		assertCollection: squares 
		includesAll: 
			(#( e6 d6 ) collect: [ :name | board at: name ])
]

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
