.class Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;
.super Ljava/lang/Object;
.source "SegmentHeader.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x2
    name = "Counter"
.end annotation


# instance fields
.field private final counts:[I

.field private length:I

.field private final objs:[I

.field final synthetic this$0:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;


# direct methods
.method private constructor <init>(Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;)V
    .locals 1

    .line 295
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->this$0:Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 297
    const/16 p1, 0x8

    new-array v0, p1, [I

    iput-object v0, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->objs:[I

    .line 298
    new-array p1, p1, [I

    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->counts:[I

    return-void
.end method

.method synthetic constructor <init>(Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$1;)V
    .locals 0
    .param p1, "x0"    # Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;
    .param p2, "x1"    # Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$1;

    .line 295
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;-><init>(Lorg/apache/commons/compress/harmony/pack200/SegmentHeader;)V

    return-void
.end method


# virtual methods
.method public add(I)V
    .locals 5
    .param p1, "obj"    # I

    .line 302
    const/4 v0, 0x0

    .line 303
    .local v0, "found":Z
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    const/4 v3, 0x1

    if-ge v1, v2, :cond_1

    .line 304
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->objs:[I

    aget v2, v2, v1

    if-ne v2, p1, :cond_0

    .line 305
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->counts:[I

    aget v4, v2, v1

    add-int/2addr v4, v3

    aput v4, v2, v1

    .line 306
    const/4 v0, 0x1

    .line 303
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 309
    .end local v1    # "i":I
    :cond_1
    if-nez v0, :cond_2

    .line 310
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->objs:[I

    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    aput p1, v1, v2

    .line 311
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->counts:[I

    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    aput v3, v1, v2

    .line 312
    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    add-int/2addr v1, v3

    iput v1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    .line 313
    iget v1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->objs:[I

    array-length v2, v2

    sub-int/2addr v2, v3

    if-le v1, v2, :cond_2

    .line 314
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->objs:[I

    array-length v1, v1

    add-int/lit8 v1, v1, 0x8

    new-array v1, v1, [Ljava/lang/Object;

    .line 315
    .local v1, "newArray":[Ljava/lang/Object;
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->objs:[I

    iget v3, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    const/4 v4, 0x0

    invoke-static {v2, v4, v1, v4, v3}, Ljava/lang/System;->arraycopy(Ljava/lang/Object;ILjava/lang/Object;II)V

    .line 318
    .end local v1    # "newArray":[Ljava/lang/Object;
    :cond_2
    return-void
.end method

.method public getMostCommon()I
    .locals 4

    .line 321
    const/4 v0, 0x0

    .line 322
    .local v0, "returnIndex":I
    const/4 v1, 0x0

    .local v1, "i":I
    :goto_0
    iget v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->length:I

    if-ge v1, v2, :cond_1

    .line 323
    iget-object v2, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->counts:[I

    aget v2, v2, v1

    iget-object v3, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->counts:[I

    aget v3, v3, v0

    if-le v2, v3, :cond_0

    .line 324
    move v0, v1

    .line 322
    :cond_0
    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    .line 327
    .end local v1    # "i":I
    :cond_1
    iget-object v1, p0, Lorg/apache/commons/compress/harmony/pack200/SegmentHeader$Counter;->objs:[I

    aget v1, v1, v0

    return v1
.end method
