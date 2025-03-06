new_iam_token:
	yc iam create-token

terraform-%:
	make -C terraform $*

ansible-%:
	make -C ansible $*
