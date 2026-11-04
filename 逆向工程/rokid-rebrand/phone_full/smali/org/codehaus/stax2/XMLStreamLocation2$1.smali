.class final Lorg/codehaus/stax2/XMLStreamLocation2$1;
.super Ljava/lang/Object;
.source "XMLStreamLocation2.java"

# interfaces
.implements Lorg/codehaus/stax2/XMLStreamLocation2;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lorg/codehaus/stax2/XMLStreamLocation2;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x8
    name = null
.end annotation


# direct methods
.method constructor <init>()V
    .locals 0

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getCharacterOffset()I
    .locals 1

    .line 24
    const/4 v0, -0x1

    return v0
.end method

.method public getColumnNumber()I
    .locals 1

    .line 29
    const/4 v0, -0x1

    return v0
.end method

.method public getContext()Lorg/codehaus/stax2/XMLStreamLocation2;
    .locals 1

    .line 19
    const/4 v0, 0x0

    return-object v0
.end method

.method public getLineNumber()I
    .locals 1

    .line 34
    const/4 v0, -0x1

    return v0
.end method

.method public getPublicId()Ljava/lang/String;
    .locals 1

    .line 39
    const/4 v0, 0x0

    return-object v0
.end method

.method public getSystemId()Ljava/lang/String;
    .locals 1

    .line 44
    const/4 v0, 0x0

    return-object v0
.end method
