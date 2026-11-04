.class abstract Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;
.super Ljava/lang/Object;
.source "NewAttributeBands.java"

# interfaces
.implements Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$AttributeLayoutElement;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x402
    name = "LayoutElement"
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;


# direct methods
.method private constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;)V
    .locals 0

    .line 351
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;->this$0:Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method synthetic constructor <init>(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$1;)V
    .locals 0
    .param p1, "x0"    # Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;
    .param p2, "x1"    # Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$1;

    .line 351
    invoke-direct {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands$LayoutElement;-><init>(Lorg/apache/commons/compress/harmony/unpack200/NewAttributeBands;)V

    return-void
.end method


# virtual methods
.method protected getLength(C)I
    .locals 1
    .param p1, "uint_type"    # C

    .line 354
    const/4 v0, 0x0

    .line 355
    .local v0, "length":I
    sparse-switch p1, :sswitch_data_0

    goto :goto_0

    .line 366
    :sswitch_0
    const/4 v0, 0x0

    goto :goto_0

    .line 363
    :sswitch_1
    const/4 v0, 0x4

    .line 364
    goto :goto_0

    .line 360
    :sswitch_2
    const/4 v0, 0x2

    .line 361
    goto :goto_0

    .line 357
    :sswitch_3
    const/4 v0, 0x1

    .line 358
    nop

    .line 369
    :goto_0
    return v0

    :sswitch_data_0
    .sparse-switch
        0x42 -> :sswitch_3
        0x48 -> :sswitch_2
        0x49 -> :sswitch_1
        0x56 -> :sswitch_0
    .end sparse-switch
.end method
