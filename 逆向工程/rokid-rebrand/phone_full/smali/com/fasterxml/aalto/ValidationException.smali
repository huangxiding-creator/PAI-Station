.class public Lcom/fasterxml/aalto/ValidationException;
.super Lorg/codehaus/stax2/validation/XMLValidationException;
.source "ValidationException.java"


# direct methods
.method protected constructor <init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;)V
    .locals 0
    .param p1, "cause"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;
    .param p2, "msg"    # Ljava/lang/String;

    .line 27
    invoke-direct {p0, p1, p2}, Lorg/codehaus/stax2/validation/XMLValidationException;-><init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;)V

    .line 28
    return-void
.end method

.method protected constructor <init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "cause"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "loc"    # Ljavax/xml/stream/Location;

    .line 32
    invoke-direct {p0, p1, p2, p3}, Lorg/codehaus/stax2/validation/XMLValidationException;-><init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;Ljavax/xml/stream/Location;)V

    .line 33
    return-void
.end method

.method public static create(Lorg/codehaus/stax2/validation/XMLValidationProblem;)Lcom/fasterxml/aalto/ValidationException;
    .locals 3
    .param p0, "cause"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;

    .line 38
    invoke-virtual {p0}, Lorg/codehaus/stax2/validation/XMLValidationProblem;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    .line 39
    .local v0, "loc":Ljavax/xml/stream/Location;
    if-nez v0, :cond_0

    .line 40
    new-instance v1, Lcom/fasterxml/aalto/ValidationException;

    invoke-virtual {p0}, Lorg/codehaus/stax2/validation/XMLValidationProblem;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, p0, v2}, Lcom/fasterxml/aalto/ValidationException;-><init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;)V

    return-object v1

    .line 42
    :cond_0
    new-instance v1, Lcom/fasterxml/aalto/ValidationException;

    invoke-virtual {p0}, Lorg/codehaus/stax2/validation/XMLValidationProblem;->getMessage()Ljava/lang/String;

    move-result-object v2

    invoke-direct {v1, p0, v2, v0}, Lcom/fasterxml/aalto/ValidationException;-><init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;Ljavax/xml/stream/Location;)V

    return-object v1
.end method


# virtual methods
.method protected getLocationDesc()Ljava/lang/String;
    .locals 2

    .line 90
    invoke-virtual {p0}, Lcom/fasterxml/aalto/ValidationException;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v0

    .line 91
    .local v0, "loc":Ljavax/xml/stream/Location;
    if-nez v0, :cond_0

    const/4 v1, 0x0

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v1

    :goto_0
    return-object v1
.end method

.method public getMessage()Ljava/lang/String;
    .locals 5

    .line 60
    invoke-virtual {p0}, Lcom/fasterxml/aalto/ValidationException;->getLocationDesc()Ljava/lang/String;

    move-result-object v0

    .line 65
    .local v0, "locMsg":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 66
    invoke-super {p0}, Lorg/codehaus/stax2/validation/XMLValidationException;->getMessage()Ljava/lang/String;

    move-result-object v1

    return-object v1

    .line 68
    :cond_0
    invoke-virtual {p0}, Lcom/fasterxml/aalto/ValidationException;->getValidationProblem()Lorg/codehaus/stax2/validation/XMLValidationProblem;

    move-result-object v1

    invoke-virtual {v1}, Lorg/codehaus/stax2/validation/XMLValidationProblem;->getMessage()Ljava/lang/String;

    move-result-object v1

    .line 69
    .local v1, "msg":Ljava/lang/String;
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/String;->length()I

    move-result v3

    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v4

    add-int/2addr v3, v4

    add-int/lit8 v3, v3, 0x14

    invoke-direct {v2, v3}, Ljava/lang/StringBuilder;-><init>(I)V

    .line 70
    .local v2, "sb":Ljava/lang/StringBuilder;
    invoke-virtual {v2, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 71
    const/16 v3, 0xa

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    .line 72
    const-string v3, " at "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 73
    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    .line 74
    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    return-object v3
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    .line 79
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/Class;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ": "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p0}, Lcom/fasterxml/aalto/ValidationException;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
