main 	START 	0

.Read section
Read	JSUB	stinit		.Read the device and store data to 'record'
	JSUB	pushR
	LDX	#0		
	LDA	#0
Rloop	TD	indev
	JEQ	Rloop
	RD	indev
	STCH	record, X
	COMP	#10
	JEQ	Check
	TIX	#9
	JLT	Rloop
	J	UsPopL	

.Using popL
UsPopL	JSUB	popL

.Check section
Check	LDX	#0		.Check input device's first char is same to 'i', 'l', 'd', 'f'
	LDCH	record	
	STA	save
	LDCH	input
	COMP	save
	JEQ	ICloop
	LDCH	list
	COMP	save
	JEQ	LCloop
	LDCH	delete
	COMP	save
	JEQ	DCloop
	LDCH	find
	COMP	save
	JEQ	FCloop
	J 	UsPopL

ICloop	TIX	#5		.Check input device's string is same to 'input'
	JEQ	ISect
	LDCH	record, X	
	STA	save
	LDCH	input, X
	COMP	save
	JEQ	ICloop
	J	UsPopL

LCloop	TIX	#4		.Check input device's string is same to 'list'
	JEQ	LSect
	LDCH	record, X	
	STA	save
	LDCH	list, X	
	COMP	save
	JEQ	LCloop
	J	UsPopL	

DCloop	TIX	#6		.Check input device's string is same to 'delete'
	JEQ	DSect
	LDCH	record, X	
	STA	save
	LDCH	delete, X	
	COMP	save
	JEQ	DCloop
	J	UsPopL	

FCloop	TIX	#4		.Check input device's string is same to 'find'
	JEQ	FSect
	LDCH	record, X	
	STA	save
	LDCH	find, X	
	COMP	save
	JEQ	FCloop
	J	UsPopL

.Init section
Init	TIX	#100		.Init the save to record's last char
	LDCH	record, X
	STA	save
	RSUB

.Input section
ISect	JSUB	Init		.Input the record data to tree
	LDA	tNum
	COMP	#15
	JEQ	Ifull
	LDA	tMax
	ADD	#1
	STA	tMax
	LDA	save
	LDX	tNum
	STCH	tree, X

CNone	TIX	#15		.Check what node is none data
	LDA	tNum
	ADD	#1
	STA	tNum
	JEQ	UsPopL
	LDCH	tree, X
	COMP	#0
	JEQ	UsPopL
	J	CNone

Ifull	LDX	#0		
Iloop	TD	outdev		.if tree is full, print 'FULL'
	JEQ	Iloop
	LDCH	full, X
	WD	outdev
	TIX	#4
	JLT	Iloop
	JSUB	Enter
	J	UsPopL

.List section
LSect	LDX	#0		.Postorder traversal to print list of tree
	LDA	#0
	STA	svNum

PostOd	LDA	#0		.if tree has none data or node num is over 14, do recursive call
	LDX	svNum		
	LDCH	tree, X
	COMP	#0
	JEQ	UsPopL
	LDA	svNum
	COMP	#14
	JGT	UsPopL	

	JSUB	push		.Left child section
	LDA	svNum
	MUL	#2
	ADD	#1
	STA	svNum
	JSUB	pushL
	J	PostOd

	JSUB	pop		.Right child section
	STA	svNum
	JSUB	push
	LDA	svNum
	MUL	#2
	ADD	#2
	STA	svNum
	JSUB	pushL
	J	PostOd

	JSUB	pop		.Parent section
	RMO	A, X
	LDCH	tree, X
	JSUB	Print
	J	UsPopL

.Delete section
DSect	JSUB	Init
	LDX	#0
	LDA	#0

Dloop	STX	svNum
	LDCH	tree, X
	COMP	save
	JEQ	Dinit
	TIX	#15
	JEQ	PNone
	J	Dloop

Dinit	JSUB	Enter
Delete	LDA	#0		.Delete specific node and its child node
	LDX	svNum		
	LDCH	tree, X
	COMP	#0
	JEQ	UsPopL
	LDA	svNum
	COMP	#14
	JGT	UsPopL	

	JSUB	push		.Left child section
	LDA	svNum
	MUL	#2
	ADD	#1
	STA	svNum
	JSUB	pushL
	J	Delete

	JSUB	pop		.Right child section
	STA	svNum
	JSUB	push
	LDA	svNum
	MUL	#2
	ADD	#2
	STA	svNum
	JSUB	pushL
	J	Delete

	JSUB	pop		.Parent section
	STA	tNum
	RMO	A, X
	LDA	#0
	STCH	tree, X
	LDA	tMax
	SUB	#1
	STA	tMax
	J	UsPopL

.Find section
FSect	JSUB	Init		.Inorder traversal to find specific char of tree
	LDX	#0
	LDCH	tree, X
	COMP	#0
	JEQ	PNone
	LDA	#0
	STA	svNum
	STA	tCnt

InOd	LDA	#0		.if tree has none data or node num is over 14, do recursive call
	LDX	svNum		
	LDCH	tree, X
	COMP	#0
	JEQ	UsPopL
	LDA	svNum
	COMP	#14
	JGT	UsPopL

	JSUB	push		.Left child section
	LDA	svNum
	MUL	#2
	ADD	#1
	STA	svNum
	JSUB	pushL
	J	InOd

	LDA	tCnt		.Parent section
	ADD	#1
	STA	tCnt
	JSUB	pop
	STA	svNum
	RMO	A, X
	LDCH	tree, X
	JSUB	Print
	LDCH	tree, X
	COMP	save
	JEQ	findT
	LDA	#0
	LDA	tMax
	COMP	tCnt
	JEQ	PNone

	LDA	svNum		.Right child section
	MUL	#2
	ADD	#2
	STA	svNum
	J	InOd

findT	LDA	tCnt		.if find specific node, print tCnt
	COMP	#10
	JLT	one
ten	SUB	#10
	STA	tCnt
	LDCH	n1
	ADD	#1
tenP	TD	outdev
	JEQ	tenP
	WD	outdev
one	LDCH	n1
	ADD	tCnt
	JSUB	Print
	J	UsPopL

.Print section
Print	TD	outdev		.Print each node of the tree
	JEQ	Print
	WD	outdev

Enter	TD	outdev
	JEQ	Enter
	LDCH	enter
	WD	outdev
	RSUB

PNone	LDX	#0		.print 'NONE'
	LDA	#0
Nloop	TD	outdev		
	JEQ	Nloop
	LDCH	none, X
	WD	outdev
	TIX	#4
	JLT	Nloop
	JSUB	Enter
	J	UsPopL

.stack section
stinit	LDA 	#stack		.init stack and stackL
	STA	top
	LDA	#stackL
	STA	topL
	RSUB

pushR	RMO	L, A		.init stackL's first entry pointing Read section
	SUB	#6
	STA	@topL
	LDA	topL
	ADD	#3
	STA	topL
	RSUB
	
push 	STA 	@top		.push data to stack
	LDA 	top
	ADD 	#3
	STA 	top
	RSUB

pop 	LDA 	top		.pop data in stack
	SUB 	#3
	STA 	top
	LDA 	@top
	RSUB

pushL	RMO	L, A		.push L value +3(next line) to stackL
	ADD	#3
	STA	@topL		
	LDA	topL
	ADD	#3
	STA	topL
	RSUB

popL	LDA	topL		.pop L value in stackL
	SUB	#3
	STA	topL
	LDL	@topL
	RSUB

.Variable section
indev	BYTE	0
outdev	BYTE	1
record	RESB	9

save	WORD	0
svNum	WORD	0

input	BYTE	C'INPUT'
list	BYTE	C'LIST'
delete	BYTE	C'DELETE'
find	BYTE	C'FIND'
full	BYTE	C'FULL'
none	BYTE	C'NONE'
n1	BYTE	C'0'
enter	BYTE	10

tree	RESB	15
tNum	WORD	0
tMax	WORD	0
tCnt	WORD	0

top	RESW	1
stack	RESW 	10
topL	RESW	1
stackL	RESW	10

	END	main