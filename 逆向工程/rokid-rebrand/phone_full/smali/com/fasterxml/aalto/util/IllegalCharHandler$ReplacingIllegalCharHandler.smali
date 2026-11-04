.class public Lcom/fasterxml/aalto/util/IllegalCharHandler$ReplacingIllegalCharHandler;
.super Ljava/lang/Object;
.source "IllegalCharHandler.java"

# interfaces
.implements Lcom/fasterxml/aalto/util/IllegalCharHandler;
.implements Lcom/fasterxml/aalto/util/XmlConsts;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/fasterxml/aalto/util/IllegalCharHandler;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "ReplacingIllegalCharHandler"
.end annotation


# instance fields
.field private final replacedChar:C


# direct methods
.method public constructor <init>(C)V
    .locals 0
    .param p1, "replacedChar"    # C

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    iput-char p1, p0, Lcom/fasterxml/aalto/util/IllegalCharHandler$ReplacingIllegalCharHandler;->replacedChar:C

    .line 17
    return-void
.end method


# virtual methods
.method public convertIllegalChar(I)C
    .locals 1
    .param p1, "invalidChar"    # I
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/fasterxml/aalto/WFCException;
        }
    .end annotation

    .line 22
    iget-char v0, p0, Lcom/fasterxml/aalto/util/IllegalCharHandler$ReplacingIllegalCharHandler;->replacedChar:C

    return v0
.end method
