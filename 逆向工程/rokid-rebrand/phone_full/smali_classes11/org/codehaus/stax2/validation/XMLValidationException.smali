.class public Lorg/codehaus/stax2/validation/XMLValidationException;
.super Ljavax/xml/stream/XMLStreamException;
.source "XMLValidationException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# instance fields
.field protected mCause:Lorg/codehaus/stax2/validation/XMLValidationProblem;


# direct methods
.method protected constructor <init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;)V
    .locals 0
    .param p1, "cause"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;

    .line 30
    invoke-direct {p0}, Ljavax/xml/stream/XMLStreamException;-><init>()V

    .line 31
    if-nez p1, :cond_0

    .line 32
    invoke-static {}, Lorg/codehaus/stax2/validation/XMLValidationException;->throwMissing()V

    .line 34
    :cond_0
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationException;->mCause:Lorg/codehaus/stax2/validation/XMLValidationProblem;

    .line 35
    return-void
.end method

.method protected constructor <init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;)V
    .locals 0
    .param p1, "cause"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;
    .param p2, "msg"    # Ljava/lang/String;

    .line 39
    invoke-direct {p0, p2}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;)V

    .line 40
    if-nez p1, :cond_0

    .line 41
    invoke-static {}, Lorg/codehaus/stax2/validation/XMLValidationException;->throwMissing()V

    .line 43
    :cond_0
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationException;->mCause:Lorg/codehaus/stax2/validation/XMLValidationProblem;

    .line 44
    return-void
.end method

.method protected constructor <init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "cause"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "loc"    # Ljavax/xml/stream/Location;

    .line 49
    invoke-direct {p0, p2, p3}, Ljavax/xml/stream/XMLStreamException;-><init>(Ljava/lang/String;Ljavax/xml/stream/Location;)V

    .line 50
    if-nez p1, :cond_0

    .line 51
    invoke-static {}, Lorg/codehaus/stax2/validation/XMLValidationException;->throwMissing()V

    .line 53
    :cond_0
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationException;->mCause:Lorg/codehaus/stax2/validation/XMLValidationProblem;

    .line 54
    return-void
.end method

.method public static createException(Lorg/codehaus/stax2/validation/XMLValidationProblem;)Lorg/codehaus/stax2/validation/XMLValidationException;
    .locals 3
    .param p0, "cause"    # Lorg/codehaus/stax2/validation/XMLValidationProblem;

    .line 60
    invoke-virtual {p0}, Lorg/codehaus/stax2/validation/XMLValidationProblem;->getMessage()Ljava/lang/String;

    move-result-object v0

    .line 61
    .local v0, "msg":Ljava/lang/String;
    if-nez v0, :cond_0

    .line 62
    new-instance v1, Lorg/codehaus/stax2/validation/XMLValidationException;

    invoke-direct {v1, p0}, Lorg/codehaus/stax2/validation/XMLValidationException;-><init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;)V

    return-object v1

    .line 64
    :cond_0
    invoke-virtual {p0}, Lorg/codehaus/stax2/validation/XMLValidationProblem;->getLocation()Ljavax/xml/stream/Location;

    move-result-object v1

    .line 65
    .local v1, "loc":Ljavax/xml/stream/Location;
    if-nez v1, :cond_1

    .line 66
    new-instance v2, Lorg/codehaus/stax2/validation/XMLValidationException;

    invoke-direct {v2, p0, v0}, Lorg/codehaus/stax2/validation/XMLValidationException;-><init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;)V

    return-object v2

    .line 68
    :cond_1
    new-instance v2, Lorg/codehaus/stax2/validation/XMLValidationException;

    invoke-direct {v2, p0, v0, v1}, Lorg/codehaus/stax2/validation/XMLValidationException;-><init>(Lorg/codehaus/stax2/validation/XMLValidationProblem;Ljava/lang/String;Ljavax/xml/stream/Location;)V

    return-object v2
.end method

.method protected static throwMissing()V
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/RuntimeException;
        }
    .end annotation

    .line 86
    new-instance v0, Ljava/lang/IllegalArgumentException;

    const-string v1, "Validation problem argument can not be null"

    invoke-direct {v0, v1}, Ljava/lang/IllegalArgumentException;-><init>(Ljava/lang/String;)V

    throw v0
.end method


# virtual methods
.method public getValidationProblem()Lorg/codehaus/stax2/validation/XMLValidationProblem;
    .locals 1

    .line 78
    iget-object v0, p0, Lorg/codehaus/stax2/validation/XMLValidationException;->mCause:Lorg/codehaus/stax2/validation/XMLValidationProblem;

    return-object v0
.end method
