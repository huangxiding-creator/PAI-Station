.class public Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;
.super Ljava/lang/Object;
.source "CodecEncoding.java"


# static fields
.field private static final canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

.field private static canonicalCodecsToSpecifiers:Ljava/util/Map;


# direct methods
.method static constructor <clinit>()V
    .locals 18

    .line 35
    const/16 v0, 0x74

    new-array v0, v0, [Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/4 v1, 0x0

    const/4 v2, 0x0

    aput-object v1, v0, v2

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/4 v3, 0x1

    const/16 v4, 0x100

    invoke-direct {v1, v3, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    aput-object v1, v0, v3

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v3, v4, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/4 v5, 0x2

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v3, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/4 v6, 0x3

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v3, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/4 v7, 0x4

    aput-object v1, v0, v7

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/4 v8, 0x5

    aput-object v1, v0, v8

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/4 v9, 0x6

    aput-object v1, v0, v9

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/4 v9, 0x7

    aput-object v1, v0, v9

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v9, 0x8

    aput-object v1, v0, v9

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v10, 0x9

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v4, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v10, 0xa

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v10, 0xb

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v10, 0xc

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v7, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v10, 0xd

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v7, v4, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v10, 0xe

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v7, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v10, 0xf

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v7, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x10

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v7}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v10, 0x11

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v7, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v10, 0x12

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v7, v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v10, 0x13

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v4}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v10, 0x14

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v4, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v10, 0x15

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v4, v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v10, 0x16

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v10, 0x20

    invoke-direct {v1, v8, v10}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v11, 0x17

    aput-object v1, v0, v11

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v10, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v11, 0x18

    aput-object v1, v0, v11

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v10, v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v11, 0x19

    aput-object v1, v0, v11

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v11, 0x40

    invoke-direct {v1, v8, v11}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v12, 0x1a

    aput-object v1, v0, v12

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v11, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v12, 0x1b

    aput-object v1, v0, v12

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v11, v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v12, 0x1c

    aput-object v1, v0, v12

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v12, 0x80

    invoke-direct {v1, v8, v12}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v13, 0x1d

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v12, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v13, 0x1e

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v12, v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(III)V

    const/16 v13, 0x1f

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v7, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    aput-object v1, v0, v10

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v7, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x21

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v7, v5, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x22

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x23

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x24

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v4, v5, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x25

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v10, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x26

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v10, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x27

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v10, v5, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x28

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v11, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x29

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v11, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x2a

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v11, v5, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x2b

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v12, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x2c

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v12, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v13, 0x2d

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v8, v12, v5, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v8, 0x2e

    aput-object v1, v0, v8

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v8, 0xc0

    invoke-direct {v1, v5, v8}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v13, 0x2f

    aput-object v1, v0, v13

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v13, 0xe0

    invoke-direct {v1, v5, v13}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v14, 0x30

    aput-object v1, v0, v14

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v14, 0xf0

    invoke-direct {v1, v5, v14}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v15, 0x31

    aput-object v1, v0, v15

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v15, 0xf8

    invoke-direct {v1, v5, v15}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v16, 0x32

    aput-object v1, v0, v16

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/16 v7, 0xfc

    invoke-direct {v1, v5, v7}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v17, 0x33

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v9, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x34

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v9, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x35

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x36

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x37

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v10, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x38

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v10, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x39

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v11, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x3a

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v11, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x3b

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v12, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x3c

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v12, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x3d

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v8, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x3e

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v8, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x3f

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v13, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    aput-object v1, v0, v11

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v13, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x41

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v14, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x42

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v14, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x43

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v15, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v17, 0x44

    aput-object v1, v0, v17

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v15, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x45

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v8}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v5, 0x46

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v13}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v5, 0x47

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v14}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v5, 0x48

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v15}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v5, 0x49

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v7}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v5, 0x4a

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v9, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x4b

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v9, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x4c

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x4d

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x4e

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v10, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x4f

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v10, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x50

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v11, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x51

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v11, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x52

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v12, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x53

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v12, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x54

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v8, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x55

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v8, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x56

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v13, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x57

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v13, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x58

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v14, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x59

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v14, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x5a

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v15, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x5b

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v6, v15, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v5, 0x5c

    aput-object v1, v0, v5

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/4 v5, 0x4

    invoke-direct {v1, v5, v8}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v6, 0x5d

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v13}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v6, 0x5e

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v14}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v6, 0x5f

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v15}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v6, 0x60

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v7}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(II)V

    const/16 v6, 0x61

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v9, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v6, 0x62

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v9, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v6, 0x63

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v6, 0x64

    aput-object v1, v0, v6

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v4, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x65

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v10, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x66

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v10, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x67

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v11, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x68

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v11, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x69

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v12, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x6a

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v12, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x6b

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v8, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x6c

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v8, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x6d

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v13, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x6e

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v13, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x6f

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v14, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x70

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v14, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v4, 0x71

    aput-object v1, v0, v4

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v15, v2, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v2, 0x72

    aput-object v1, v0, v2

    new-instance v1, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v1, v5, v15, v3, v3}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    const/16 v2, 0x73

    aput-object v1, v0, v2

    sput-object v0, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 29
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getCanonicalCodec(I)Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .locals 1
    .param p0, "i"    # I

    .line 301
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget-object v0, v0, p0

    return-object v0
.end method

.method public static getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;
    .locals 11
    .param p0, "value"    # I
    .param p1, "in"    # Ljava/io/InputStream;
    .param p2, "defaultCodec"    # Lorg/apache/commons/compress/harmony/pack200/Codec;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;,
            Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;
        }
    .end annotation

    .line 90
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    array-length v0, v0

    const/16 v1, 0x74

    if-ne v0, v1, :cond_18

    .line 93
    if-ltz p0, :cond_17

    .line 96
    if-nez p0, :cond_0

    .line 97
    return-object p2

    .line 99
    :cond_0
    const/16 v0, 0x73

    if-gt p0, v0, :cond_1

    .line 100
    sget-object v0, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget-object v0, v0, p0

    return-object v0

    .line 102
    :cond_1
    const/4 v0, 0x3

    const/4 v2, 0x1

    if-ne p0, v1, :cond_4

    .line 103
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v1

    .line 104
    .local v1, "code":I
    const-string v3, "End of buffer read whilst trying to decode codec"

    const/4 v4, -0x1

    if-eq v1, v4, :cond_3

    .line 107
    and-int/lit8 v5, v1, 0x1

    .line 108
    .local v5, "d":I
    shr-int/lit8 v6, v1, 0x1

    and-int/2addr v0, v6

    .line 109
    .local v0, "s":I
    shr-int/lit8 v6, v1, 0x3

    and-int/lit8 v6, v6, 0x7

    add-int/2addr v6, v2

    .line 112
    .local v6, "b":I
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v1

    .line 113
    if-eq v1, v4, :cond_2

    .line 116
    add-int/lit8 v2, v1, 0x1

    .line 118
    .local v2, "h":I
    new-instance v3, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    invoke-direct {v3, v6, v2, v0, v5}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;-><init>(IIII)V

    return-object v3

    .line 114
    .end local v2    # "h":I
    :cond_2
    new-instance v2, Ljava/io/EOFException;

    invoke-direct {v2, v3}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v2

    .line 105
    .end local v0    # "s":I
    .end local v5    # "d":I
    .end local v6    # "b":I
    :cond_3
    new-instance v0, Ljava/io/EOFException;

    invoke-direct {v0, v3}, Ljava/io/EOFException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 120
    .end local v1    # "code":I
    :cond_4
    const/16 v1, 0x75

    const/4 v3, 0x0

    if-lt p0, v1, :cond_d

    const/16 v1, 0x8c

    if-gt p0, v1, :cond_d

    .line 121
    add-int/lit8 v1, p0, -0x75

    .line 122
    .local v1, "offset":I
    and-int/lit8 v4, v1, 0x3

    .line 123
    .local v4, "kx":I
    shr-int/lit8 v5, v1, 0x2

    and-int/2addr v5, v2

    if-ne v5, v2, :cond_5

    move v5, v2

    goto :goto_0

    :cond_5
    move v5, v3

    .line 124
    .local v5, "kbflag":Z
    :goto_0
    shr-int/lit8 v6, v1, 0x3

    and-int/2addr v6, v2

    if-ne v6, v2, :cond_6

    move v6, v2

    goto :goto_1

    :cond_6
    move v6, v3

    .line 125
    .local v6, "adef":Z
    :goto_1
    shr-int/lit8 v7, v1, 0x4

    and-int/2addr v7, v2

    if-ne v7, v2, :cond_7

    goto :goto_2

    :cond_7
    move v2, v3

    .line 128
    .local v2, "bdef":Z
    :goto_2
    if-eqz v6, :cond_9

    if-nez v2, :cond_8

    goto :goto_3

    .line 129
    :cond_8
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    const-string v3, "ADef and BDef should never both be true"

    invoke-direct {v0, v3}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 131
    :cond_9
    :goto_3
    if-eqz v5, :cond_a

    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v0

    .line 132
    .local v0, "kb":I
    :cond_a
    add-int/lit8 v3, v0, 0x1

    const-wide/high16 v7, 0x4030000000000000L    # 16.0

    int-to-double v9, v4

    invoke-static {v7, v8, v9, v10}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v7

    double-to-int v7, v7

    mul-int/2addr v3, v7

    .line 134
    .local v3, "k":I
    if-eqz v6, :cond_b

    .line 135
    move-object v7, p2

    .local v7, "aCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    goto :goto_4

    .line 137
    .end local v7    # "aCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :cond_b
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v7

    invoke-static {v7, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v7

    .line 139
    .restart local v7    # "aCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_4
    if-eqz v2, :cond_c

    .line 140
    move-object v8, p2

    .local v8, "bCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    goto :goto_5

    .line 142
    .end local v8    # "bCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :cond_c
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v8

    invoke-static {v8, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v8

    .line 144
    .restart local v8    # "bCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_5
    new-instance v9, Lorg/apache/commons/compress/harmony/pack200/RunCodec;

    invoke-direct {v9, v3, v7, v8}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;-><init>(ILorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)V

    return-object v9

    .line 146
    .end local v0    # "kb":I
    .end local v1    # "offset":I
    .end local v2    # "bdef":Z
    .end local v3    # "k":I
    .end local v4    # "kx":I
    .end local v5    # "kbflag":Z
    .end local v6    # "adef":Z
    .end local v7    # "aCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v8    # "bCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :cond_d
    const/16 v0, 0x8d

    if-lt p0, v0, :cond_16

    const/16 v0, 0xbc

    if-gt p0, v0, :cond_16

    .line 149
    add-int/lit16 v0, p0, -0x8d

    .line 150
    .local v0, "offset":I
    and-int/lit8 v1, v0, 0x1

    if-ne v1, v2, :cond_e

    move v1, v2

    goto :goto_6

    :cond_e
    move v1, v3

    .line 151
    .local v1, "fdef":Z
    :goto_6
    shr-int/lit8 v4, v0, 0x1

    and-int/2addr v4, v2

    if-ne v4, v2, :cond_f

    move v4, v2

    goto :goto_7

    :cond_f
    move v4, v3

    .line 152
    .local v4, "udef":Z
    :goto_7
    shr-int/lit8 v5, v0, 0x2

    .line 153
    .local v5, "tdefl":I
    if-eqz v5, :cond_10

    goto :goto_8

    :cond_10
    move v2, v3

    .line 155
    .local v2, "tdef":Z
    :goto_8
    const/16 v3, 0xc

    new-array v3, v3, [I

    fill-array-data v3, :array_0

    .line 156
    .local v3, "tdefToL":[I
    aget v6, v3, v5

    .line 160
    .local v6, "l":I
    if-eqz v2, :cond_13

    .line 161
    if-eqz v1, :cond_11

    move-object v7, p2

    goto :goto_9

    :cond_11
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v7

    invoke-static {v7, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v7

    .line 162
    .local v7, "fCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_9
    if-eqz v4, :cond_12

    move-object v8, p2

    goto :goto_a

    :cond_12
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v8

    invoke-static {v8, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v8

    .line 168
    .local v8, "uCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_a
    new-instance v9, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    invoke-direct {v9, v7, v6, v8}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;-><init>(Lorg/apache/commons/compress/harmony/pack200/Codec;ILorg/apache/commons/compress/harmony/pack200/Codec;)V

    return-object v9

    .line 170
    .end local v7    # "fCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v8    # "uCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :cond_13
    if-eqz v1, :cond_14

    move-object v7, p2

    goto :goto_b

    :cond_14
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v7

    invoke-static {v7, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v7

    .line 171
    .restart local v7    # "fCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_b
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v8

    invoke-static {v8, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v8

    .line 172
    .local v8, "tCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    if-eqz v4, :cond_15

    move-object v9, p2

    goto :goto_c

    :cond_15
    invoke-virtual {p1}, Ljava/io/InputStream;->read()I

    move-result v9

    invoke-static {v9, p1, p2}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getCodec(ILjava/io/InputStream;Lorg/apache/commons/compress/harmony/pack200/Codec;)Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v9

    .line 173
    .local v9, "uCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :goto_c
    new-instance v10, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    invoke-direct {v10, v7, v8, v9}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;-><init>(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)V

    return-object v10

    .line 147
    .end local v0    # "offset":I
    .end local v1    # "fdef":Z
    .end local v2    # "tdef":Z
    .end local v3    # "tdefToL":[I
    .end local v4    # "udef":Z
    .end local v5    # "tdefl":I
    .end local v6    # "l":I
    .end local v7    # "fCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v8    # "tCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v9    # "uCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    :cond_16
    new-instance v0, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "Invalid codec encoding byte ("

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ") found"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Lorg/apache/commons/compress/harmony/pack200/Pack200Exception;-><init>(Ljava/lang/String;)V

    throw v0

    .line 94
    :cond_17
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Encoding cannot be less than zero"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0

    .line 91
    :cond_18
    new-instance v0, Ljava/lang/Error;

    const-string v1, "Canonical encodings have been incorrectly modified"

    invoke-direct {v0, v1}, Ljava/lang/Error;-><init>(Ljava/lang/String;)V

    throw v0

    nop

    :array_0
    .array-data 4
        0x0
        0x4
        0x8
        0x10
        0x20
        0x40
        0x80
        0xc0
        0xe0
        0xf0
        0xf8
        0xfc
    .end array-data
.end method

.method public static getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I
    .locals 17
    .param p0, "codec"    # Lorg/apache/commons/compress/harmony/pack200/Codec;
    .param p1, "defaultForBand"    # Lorg/apache/commons/compress/harmony/pack200/Codec;

    .line 182
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodecsToSpecifiers:Ljava/util/Map;

    if-nez v2, :cond_1

    .line 183
    new-instance v2, Ljava/util/HashMap;

    sget-object v3, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    array-length v3, v3

    invoke-direct {v2, v3}, Ljava/util/HashMap;-><init>(I)V

    .line 184
    .local v2, "reverseMap":Ljava/util/HashMap;
    const/4 v3, 0x0

    .local v3, "i":I
    :goto_0
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    array-length v4, v4

    if-ge v3, v4, :cond_0

    .line 185
    sget-object v4, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodec:[Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    aget-object v4, v4, v3

    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v5

    invoke-virtual {v2, v4, v5}, Ljava/util/HashMap;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 184
    add-int/lit8 v3, v3, 0x1

    goto :goto_0

    .line 187
    .end local v3    # "i":I
    :cond_0
    sput-object v2, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodecsToSpecifiers:Ljava/util/Map;

    .line 190
    .end local v2    # "reverseMap":Ljava/util/HashMap;
    :cond_1
    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodecsToSpecifiers:Ljava/util/Map;

    invoke-interface {v2, v0}, Ljava/util/Map;->containsKey(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_2

    .line 191
    sget-object v2, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->canonicalCodecsToSpecifiers:Ljava/util/Map;

    invoke-interface {v2, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Integer;

    invoke-virtual {v2}, Ljava/lang/Integer;->intValue()I

    move-result v2

    filled-new-array {v2}, [I

    move-result-object v2

    return-object v2

    .line 193
    :cond_2
    instance-of v2, v0, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    const/4 v3, 0x2

    const/4 v4, 0x3

    const/4 v5, 0x0

    const/4 v6, 0x1

    if-eqz v2, :cond_3

    .line 195
    move-object v2, v0

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 196
    .local v2, "bhsdCodec":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    new-array v4, v4, [I

    .line 197
    .local v4, "specifiers":[I
    const/16 v7, 0x74

    aput v7, v4, v5

    .line 198
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->isDelta()Z

    move-result v5

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getS()I

    move-result v7

    mul-int/2addr v7, v3

    add-int/2addr v5, v7

    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getB()I

    move-result v7

    sub-int/2addr v7, v6

    mul-int/lit8 v7, v7, 0x8

    add-int/2addr v5, v7

    aput v5, v4, v6

    .line 199
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getH()I

    move-result v5

    sub-int/2addr v5, v6

    aput v5, v4, v3

    .line 200
    return-object v4

    .line 202
    .end local v2    # "bhsdCodec":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .end local v4    # "specifiers":[I
    :cond_3
    instance-of v2, v0, Lorg/apache/commons/compress/harmony/pack200/RunCodec;

    const/16 v7, 0x100

    if-eqz v2, :cond_10

    .line 203
    move-object v2, v0

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/RunCodec;

    .line 204
    .local v2, "runCodec":Lorg/apache/commons/compress/harmony/pack200/RunCodec;
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->getK()I

    move-result v8

    .line 207
    .local v8, "k":I
    if-gt v8, v7, :cond_4

    .line 208
    const/4 v7, 0x0

    .line 209
    .local v7, "kb":I
    add-int/lit8 v9, v8, -0x1

    .local v9, "kx":I
    goto :goto_1

    .line 210
    .end local v7    # "kb":I
    .end local v9    # "kx":I
    :cond_4
    const/16 v7, 0x1000

    if-gt v8, v7, :cond_5

    .line 211
    const/4 v7, 0x1

    .line 212
    .restart local v7    # "kb":I
    div-int/lit8 v9, v8, 0x10

    sub-int/2addr v9, v6

    .restart local v9    # "kx":I
    goto :goto_1

    .line 213
    .end local v7    # "kb":I
    .end local v9    # "kx":I
    :cond_5
    const/high16 v7, 0x10000

    if-gt v8, v7, :cond_6

    .line 214
    const/4 v7, 0x2

    .line 215
    .restart local v7    # "kb":I
    div-int/lit16 v9, v8, 0x100

    sub-int/2addr v9, v6

    .restart local v9    # "kx":I
    goto :goto_1

    .line 217
    .end local v7    # "kb":I
    .end local v9    # "kx":I
    :cond_6
    const/4 v7, 0x3

    .line 218
    .restart local v7    # "kb":I
    div-int/lit16 v9, v8, 0x1000

    sub-int/2addr v9, v6

    .line 220
    .restart local v9    # "kx":I
    :goto_1
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->getACodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v10

    .line 221
    .local v10, "aCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/RunCodec;->getBCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v11

    .line 222
    .local v11, "bCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    const/4 v12, 0x0

    .line 223
    .local v12, "abDef":I
    invoke-virtual {v10, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_7

    .line 224
    const/4 v12, 0x1

    goto :goto_2

    .line 225
    :cond_7
    invoke-virtual {v11, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v13

    if-eqz v13, :cond_8

    .line 226
    const/4 v12, 0x2

    .line 228
    :cond_8
    :goto_2
    add-int/lit8 v13, v7, 0x75

    if-ne v9, v4, :cond_9

    move v14, v5

    goto :goto_3

    :cond_9
    const/4 v14, 0x4

    :goto_3
    add-int/2addr v13, v14

    mul-int/lit8 v14, v12, 0x8

    add-int/2addr v13, v14

    .line 229
    .local v13, "first":I
    if-ne v12, v6, :cond_a

    new-array v14, v5, [I

    goto :goto_4

    :cond_a
    invoke-static {v10, v1}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v14

    .line 230
    .local v14, "aSpecifier":[I
    :goto_4
    if-ne v12, v3, :cond_b

    new-array v3, v5, [I

    goto :goto_5

    :cond_b
    invoke-static {v11, v1}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v3

    .line 231
    .local v3, "bSpecifier":[I
    :goto_5
    if-ne v9, v4, :cond_c

    move v15, v5

    goto :goto_6

    :cond_c
    move v15, v6

    :goto_6
    add-int/2addr v15, v6

    array-length v6, v14

    add-int/2addr v15, v6

    array-length v6, v3

    add-int/2addr v15, v6

    new-array v6, v15, [I

    .line 232
    .local v6, "specifier":[I
    aput v13, v6, v5

    .line 233
    const/4 v5, 0x1

    .line 234
    .local v5, "index":I
    if-eq v9, v4, :cond_d

    .line 235
    const/4 v4, 0x1

    aput v9, v6, v4

    .line 236
    add-int/lit8 v5, v5, 0x1

    .line 238
    :cond_d
    const/4 v4, 0x0

    .local v4, "i":I
    :goto_7
    array-length v15, v14

    if-ge v4, v15, :cond_e

    .line 239
    aget v15, v14, v4

    aput v15, v6, v5

    .line 240
    add-int/lit8 v5, v5, 0x1

    .line 238
    add-int/lit8 v4, v4, 0x1

    goto :goto_7

    .line 242
    .end local v4    # "i":I
    :cond_e
    const/4 v4, 0x0

    .restart local v4    # "i":I
    :goto_8
    array-length v15, v3

    if-ge v4, v15, :cond_f

    .line 243
    aget v15, v3, v4

    aput v15, v6, v5

    .line 244
    add-int/lit8 v5, v5, 0x1

    .line 242
    add-int/lit8 v4, v4, 0x1

    goto :goto_8

    .line 246
    .end local v4    # "i":I
    :cond_f
    return-object v6

    .line 248
    .end local v2    # "runCodec":Lorg/apache/commons/compress/harmony/pack200/RunCodec;
    .end local v3    # "bSpecifier":[I
    .end local v5    # "index":I
    .end local v6    # "specifier":[I
    .end local v7    # "kb":I
    .end local v8    # "k":I
    .end local v9    # "kx":I
    .end local v10    # "aCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v11    # "bCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v12    # "abDef":I
    .end local v13    # "first":I
    .end local v14    # "aSpecifier":[I
    :cond_10
    instance-of v2, v0, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    if-eqz v2, :cond_19

    .line 249
    move-object v2, v0

    check-cast v2, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;

    .line 250
    .local v2, "populationCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getTokenCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v3

    .line 251
    .local v3, "tokenCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getFavouredCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v4

    .line 252
    .local v4, "favouredCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getUnfavouredCodec()Lorg/apache/commons/compress/harmony/pack200/Codec;

    move-result-object v6

    .line 253
    .local v6, "unfavouredCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    invoke-virtual {v4, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v8

    .line 254
    .local v8, "fDef":I
    invoke-virtual {v6, v1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v9

    .line 255
    .local v9, "uDef":I
    const/4 v10, 0x0

    .line 256
    .local v10, "tDefL":I
    invoke-virtual {v2}, Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;->getFavoured()[I

    move-result-object v11

    .line 257
    .local v11, "favoured":[I
    if-eqz v11, :cond_12

    .line 258
    array-length v12, v11

    .line 259
    .local v12, "k":I
    sget-object v13, Lorg/apache/commons/compress/harmony/pack200/Codec;->BYTE1:Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    if-ne v3, v13, :cond_11

    .line 260
    const/4 v10, 0x1

    goto :goto_9

    .line 261
    :cond_11
    instance-of v13, v3, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    if-eqz v13, :cond_12

    .line 262
    move-object v13, v3

    check-cast v13, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 263
    .local v13, "tokenBHSD":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getS()I

    move-result v14

    if-nez v14, :cond_12

    .line 264
    const/16 v14, 0xb

    new-array v14, v14, [I

    fill-array-data v14, :array_0

    .line 265
    .local v14, "possibleLValues":[I
    invoke-virtual {v13}, Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;->getH()I

    move-result v15

    sub-int/2addr v7, v15

    .line 266
    .local v7, "l":I
    invoke-static {v14, v7}, Ljava/util/Arrays;->binarySearch([II)I

    move-result v15

    .line 267
    .local v15, "index":I
    const/4 v5, -0x1

    if-eq v15, v5, :cond_12

    .line 269
    add-int/lit8 v5, v15, 0x1

    .end local v15    # "index":I
    .restart local v5    # "index":I
    move v10, v15

    .line 274
    .end local v5    # "index":I
    .end local v7    # "l":I
    .end local v12    # "k":I
    .end local v13    # "tokenBHSD":Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;
    .end local v14    # "possibleLValues":[I
    :cond_12
    :goto_9
    add-int/lit16 v5, v8, 0x8d

    mul-int/lit8 v7, v9, 0x2

    add-int/2addr v5, v7

    mul-int/lit8 v7, v10, 0x4

    add-int/2addr v5, v7

    .line 275
    .local v5, "first":I
    const/4 v7, 0x1

    if-ne v8, v7, :cond_13

    const/4 v7, 0x0

    new-array v12, v7, [I

    goto :goto_a

    :cond_13
    const/4 v7, 0x0

    invoke-static {v4, v1}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v12

    .line 276
    .local v12, "favouredSpecifier":[I
    :goto_a
    if-eqz v10, :cond_14

    new-array v13, v7, [I

    goto :goto_b

    :cond_14
    invoke-static {v3, v1}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v13

    .line 277
    .local v13, "tokenSpecifier":[I
    :goto_b
    const/4 v14, 0x1

    if-ne v9, v14, :cond_15

    new-array v15, v7, [I

    goto :goto_c

    :cond_15
    invoke-static {v6, v1}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v15

    :goto_c
    move-object v7, v15

    .line 278
    .local v7, "unfavouredSpecifier":[I
    array-length v15, v12

    add-int/2addr v15, v14

    array-length v14, v7

    add-int/2addr v15, v14

    array-length v14, v13

    add-int/2addr v15, v14

    new-array v14, v15, [I

    .line 280
    .local v14, "specifier":[I
    const/4 v15, 0x0

    aput v5, v14, v15

    .line 281
    const/4 v15, 0x1

    .line 282
    .restart local v15    # "index":I
    const/16 v16, 0x0

    move/from16 v0, v16

    .local v0, "i":I
    :goto_d
    array-length v1, v12

    if-ge v0, v1, :cond_16

    .line 283
    aget v1, v12, v0

    aput v1, v14, v15

    .line 284
    add-int/lit8 v15, v15, 0x1

    .line 282
    add-int/lit8 v0, v0, 0x1

    move-object/from16 v1, p1

    goto :goto_d

    .line 286
    .end local v0    # "i":I
    :cond_16
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_e
    array-length v1, v13

    if-ge v0, v1, :cond_17

    .line 287
    aget v1, v13, v0

    aput v1, v14, v15

    .line 288
    add-int/lit8 v15, v15, 0x1

    .line 286
    add-int/lit8 v0, v0, 0x1

    goto :goto_e

    .line 290
    .end local v0    # "i":I
    :cond_17
    const/4 v0, 0x0

    .restart local v0    # "i":I
    :goto_f
    array-length v1, v7

    if-ge v0, v1, :cond_18

    .line 291
    aget v1, v7, v0

    aput v1, v14, v15

    .line 292
    add-int/lit8 v15, v15, 0x1

    .line 290
    add-int/lit8 v0, v0, 0x1

    goto :goto_f

    .line 294
    .end local v0    # "i":I
    :cond_18
    return-object v14

    .line 297
    .end local v2    # "populationCodec":Lorg/apache/commons/compress/harmony/pack200/PopulationCodec;
    .end local v3    # "tokenCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v4    # "favouredCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v5    # "first":I
    .end local v6    # "unfavouredCodec":Lorg/apache/commons/compress/harmony/pack200/Codec;
    .end local v7    # "unfavouredSpecifier":[I
    .end local v8    # "fDef":I
    .end local v9    # "uDef":I
    .end local v10    # "tDefL":I
    .end local v11    # "favoured":[I
    .end local v12    # "favouredSpecifier":[I
    .end local v13    # "tokenSpecifier":[I
    .end local v14    # "specifier":[I
    .end local v15    # "index":I
    :cond_19
    const/4 v0, 0x0

    return-object v0

    :array_0
    .array-data 4
        0x4
        0x8
        0x10
        0x20
        0x40
        0x80
        0xc0
        0xe0
        0xf0
        0xf8
        0xfc
    .end array-data
.end method

.method public static getSpecifierForDefaultCodec(Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;)I
    .locals 2
    .param p0, "defaultCodec"    # Lorg/apache/commons/compress/harmony/pack200/BHSDCodec;

    .line 177
    const/4 v0, 0x0

    invoke-static {p0, v0}, Lorg/apache/commons/compress/harmony/pack200/CodecEncoding;->getSpecifier(Lorg/apache/commons/compress/harmony/pack200/Codec;Lorg/apache/commons/compress/harmony/pack200/Codec;)[I

    move-result-object v0

    const/4 v1, 0x0

    aget v0, v0, v1

    return v0
.end method
