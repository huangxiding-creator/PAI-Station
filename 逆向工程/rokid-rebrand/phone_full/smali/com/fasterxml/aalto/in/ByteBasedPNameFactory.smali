.class public final Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;
.super Ljava/lang/Object;
.source "ByteBasedPNameFactory.java"


# static fields
.field private static final DO_INTERN:Z = true

.field private static final sInstance:Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 39
    new-instance v0, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;

    invoke-direct {v0}, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;-><init>()V

    sput-object v0, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;->sInstance:Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 41
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static getInstance()Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;
    .locals 1

    .line 43
    sget-object v0, Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;->sInstance:Lcom/fasterxml/aalto/in/ByteBasedPNameFactory;

    return-object v0
.end method


# virtual methods
.method public constructPName(ILjava/lang/String;III)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 10
    .param p1, "hash"    # I
    .param p2, "pname"    # Ljava/lang/String;
    .param p3, "colonIx"    # I
    .param p4, "quad1"    # I
    .param p5, "quad2"    # I

    .line 54
    if-gez p3, :cond_1

    .line 55
    move-object v0, p2

    .line 57
    .local v0, "ln":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v0

    .line 59
    if-nez p5, :cond_0

    .line 60
    new-instance v7, Lcom/fasterxml/aalto/in/PName1;

    const/4 v3, 0x0

    move-object v1, v7

    move-object v2, v0

    move-object v4, v0

    move v5, p1

    move v6, p4

    invoke-direct/range {v1 .. v6}, Lcom/fasterxml/aalto/in/PName1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    return-object v7

    .line 62
    :cond_0
    new-instance v8, Lcom/fasterxml/aalto/in/PName2;

    const/4 v3, 0x0

    move-object v1, v8

    move-object v2, v0

    move-object v4, v0

    move v5, p1

    move v6, p4

    move v7, p5

    invoke-direct/range {v1 .. v7}, Lcom/fasterxml/aalto/in/PName2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V

    return-object v8

    .line 67
    .end local v0    # "ln":Ljava/lang/String;
    :cond_1
    const/4 v0, 0x0

    invoke-virtual {p2, v0, p3}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 68
    .local v0, "prefix":Ljava/lang/String;
    add-int/lit8 v1, p3, 0x1

    invoke-virtual {p2, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 70
    .local v1, "ln":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v0

    .line 71
    invoke-virtual {v1}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v1

    .line 74
    if-nez p5, :cond_2

    .line 75
    new-instance v8, Lcom/fasterxml/aalto/in/PName1;

    move-object v2, v8

    move-object v3, p2

    move-object v4, v0

    move-object v5, v1

    move v6, p1

    move v7, p4

    invoke-direct/range {v2 .. v7}, Lcom/fasterxml/aalto/in/PName1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    return-object v8

    .line 77
    :cond_2
    new-instance v9, Lcom/fasterxml/aalto/in/PName2;

    move-object v2, v9

    move-object v3, p2

    move-object v4, v0

    move-object v5, v1

    move v6, p1

    move v7, p4

    move v8, p5

    invoke-direct/range {v2 .. v8}, Lcom/fasterxml/aalto/in/PName2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V

    return-object v9
.end method

.method public constructPName(ILjava/lang/String;I[II)Lcom/fasterxml/aalto/in/ByteBasedPName;
    .locals 17
    .param p1, "hash"    # I
    .param p2, "pname"    # Ljava/lang/String;
    .param p3, "colonIx"    # I
    .param p4, "quads"    # [I
    .param p5, "qlen"    # I

    .line 83
    move-object/from16 v7, p2

    move/from16 v8, p3

    move/from16 v9, p5

    const/4 v0, 0x4

    const/4 v1, 0x0

    if-ge v9, v0, :cond_5

    .line 84
    const/4 v0, 0x2

    const/4 v2, 0x3

    const/4 v3, 0x1

    if-gez v8, :cond_2

    .line 86
    invoke-virtual/range {p2 .. p2}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v6

    .line 88
    .end local p2    # "pname":Ljava/lang/String;
    .local v6, "pname":Ljava/lang/String;
    if-ne v9, v2, :cond_0

    .line 89
    new-instance v7, Lcom/fasterxml/aalto/in/PName3;

    const/4 v2, 0x0

    move-object v0, v7

    move-object v1, v6

    move-object v3, v6

    move/from16 v4, p1

    move-object/from16 v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/in/PName3;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[I)V

    return-object v7

    .line 90
    :cond_0
    if-ne v9, v0, :cond_1

    .line 91
    new-instance v0, Lcom/fasterxml/aalto/in/PName2;

    aget v15, p4, v1

    aget v16, p4, v3

    const/4 v12, 0x0

    move-object v10, v0

    move-object v11, v6

    move-object v13, v6

    move/from16 v14, p1

    invoke-direct/range {v10 .. v16}, Lcom/fasterxml/aalto/in/PName2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V

    return-object v0

    .line 93
    :cond_1
    new-instance v0, Lcom/fasterxml/aalto/in/PName1;

    const/4 v12, 0x0

    aget v15, p4, v1

    move-object v10, v0

    move-object v11, v6

    move-object v13, v6

    move/from16 v14, p1

    invoke-direct/range {v10 .. v15}, Lcom/fasterxml/aalto/in/PName1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    return-object v0

    .line 95
    .end local v6    # "pname":Ljava/lang/String;
    .restart local p2    # "pname":Ljava/lang/String;
    :cond_2
    invoke-virtual {v7, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v4

    .line 96
    .local v4, "prefix":Ljava/lang/String;
    add-int/lit8 v5, v8, 0x1

    invoke-virtual {v7, v5}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v5

    .line 98
    .local v5, "ln":Ljava/lang/String;
    invoke-virtual {v5}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v10

    .line 99
    .end local v5    # "ln":Ljava/lang/String;
    .local v10, "ln":Ljava/lang/String;
    invoke-virtual {v4}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v11

    .line 101
    .end local v4    # "prefix":Ljava/lang/String;
    .local v11, "prefix":Ljava/lang/String;
    if-ne v9, v2, :cond_3

    .line 102
    new-instance v6, Lcom/fasterxml/aalto/in/PName3;

    move-object v0, v6

    move-object/from16 v1, p2

    move-object v2, v11

    move-object v3, v10

    move/from16 v4, p1

    move-object/from16 v5, p4

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/in/PName3;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[I)V

    return-object v6

    .line 103
    :cond_3
    if-ne v9, v0, :cond_4

    .line 104
    new-instance v12, Lcom/fasterxml/aalto/in/PName2;

    aget v5, p4, v1

    aget v6, p4, v3

    move-object v0, v12

    move-object/from16 v1, p2

    move-object v2, v11

    move-object v3, v10

    move/from16 v4, p1

    invoke-direct/range {v0 .. v6}, Lcom/fasterxml/aalto/in/PName2;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;III)V

    return-object v12

    .line 106
    :cond_4
    new-instance v6, Lcom/fasterxml/aalto/in/PName1;

    aget v5, p4, v1

    move-object v0, v6

    move-object/from16 v1, p2

    move-object v2, v11

    move-object v3, v10

    move/from16 v4, p1

    invoke-direct/range {v0 .. v5}, Lcom/fasterxml/aalto/in/PName1;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;II)V

    return-object v6

    .line 109
    .end local v10    # "ln":Ljava/lang/String;
    .end local v11    # "prefix":Ljava/lang/String;
    :cond_5
    new-array v10, v9, [I

    .line 110
    .local v10, "buf":[I
    const/4 v0, 0x0

    .local v0, "i":I
    :goto_0
    if-ge v0, v9, :cond_6

    .line 111
    aget v2, p4, v0

    aput v2, v10, v0

    .line 110
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 113
    .end local v0    # "i":I
    :cond_6
    if-gez v8, :cond_7

    .line 115
    invoke-virtual/range {p2 .. p2}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v7

    .line 117
    .end local p2    # "pname":Ljava/lang/String;
    .local v7, "pname":Ljava/lang/String;
    new-instance v11, Lcom/fasterxml/aalto/in/PNameN;

    const/4 v2, 0x0

    move-object v0, v11

    move-object v1, v7

    move-object v3, v7

    move/from16 v4, p1

    move-object v5, v10

    move/from16 v6, p5

    invoke-direct/range {v0 .. v6}, Lcom/fasterxml/aalto/in/PNameN;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[II)V

    return-object v11

    .line 122
    .end local v7    # "pname":Ljava/lang/String;
    .restart local p2    # "pname":Ljava/lang/String;
    :cond_7
    invoke-virtual {v7, v1, v8}, Ljava/lang/String;->substring(II)Ljava/lang/String;

    move-result-object v0

    .line 123
    .local v0, "prefix":Ljava/lang/String;
    add-int/lit8 v1, v8, 0x1

    invoke-virtual {v7, v1}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v1

    .line 125
    .local v1, "ln":Ljava/lang/String;
    invoke-virtual {v1}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v11

    .line 126
    .end local v1    # "ln":Ljava/lang/String;
    .local v11, "ln":Ljava/lang/String;
    invoke-virtual {v0}, Ljava/lang/String;->intern()Ljava/lang/String;

    move-result-object v12

    .line 128
    .end local v0    # "prefix":Ljava/lang/String;
    .local v12, "prefix":Ljava/lang/String;
    new-instance v13, Lcom/fasterxml/aalto/in/PNameN;

    move-object v0, v13

    move-object/from16 v1, p2

    move-object v2, v12

    move-object v3, v11

    move/from16 v4, p1

    move-object v5, v10

    move/from16 v6, p5

    invoke-direct/range {v0 .. v6}, Lcom/fasterxml/aalto/in/PNameN;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;I[II)V

    return-object v13
.end method
