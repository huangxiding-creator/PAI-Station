.class public abstract Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands$LayoutElement;
.super Ljava/lang/Object;
.source "NewAttributeBands.java"

# interfaces
.implements Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands$AttributeLayoutElement;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x401
    name = "LayoutElement"
.end annotation


# instance fields
.field final synthetic this$0:Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands;


# direct methods
.method public constructor <init>(Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands;)V
    .locals 0
    .param p1, "this$0"    # Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands;

    .line 321
    iput-object p1, p0, Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands$LayoutElement;->this$0:Lorg/apache/commons/compress/harmony/pack200/NewAttributeBands;

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method protected getLength(C)I
    .locals 1
    .param p1, "uint_type"    # C

    .line 324
    const/4 v0, 0x0

    .line 325
    .local v0, "length":I
    sparse-switch p1, :sswitch_data_0

    goto :goto_0

    .line 336
    :sswitch_0
    const/4 v0, 0x0

    goto :goto_0

    .line 333
    :sswitch_1
    const/4 v0, 0x4

    .line 334
    goto :goto_0

    .line 330
    :sswitch_2
    const/4 v0, 0x2

    .line 331
    goto :goto_0

    .line 327
    :sswitch_3
    const/4 v0, 0x1

    .line 328
    nop

    .line 339
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
