.class public Lorg/codehaus/stax2/validation/XMLValidationProblem;
.super Ljava/lang/Object;
.source "XMLValidationProblem.java"


# static fields
.field public static final SEVERITY_ERROR:I = 0x2

.field public static final SEVERITY_FATAL:I = 0x3

.field public static final SEVERITY_WARNING:I = 0x1


# instance fields
.field protected mLocation:Ljavax/xml/stream/Location;

.field protected final mMessage:Ljava/lang/String;

.field protected mReporter:Lorg/codehaus/stax2/validation/XMLValidator;

.field protected final mSeverity:I

.field protected mType:Ljava/lang/String;


# direct methods
.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "msg"    # Ljava/lang/String;

    .line 42
    const/4 v0, 0x2

    invoke-direct {p0, p1, p2, v0}, Lorg/codehaus/stax2/validation/XMLValidationProblem;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;I)V

    .line 43
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;I)V
    .locals 1
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "severity"    # I

    .line 47
    const/4 v0, 0x0

    invoke-direct {p0, p1, p2, p3, v0}, Lorg/codehaus/stax2/validation/XMLValidationProblem;-><init>(Ljavax/xml/stream/Location;Ljava/lang/String;ILjava/lang/String;)V

    .line 48
    return-void
.end method

.method public constructor <init>(Ljavax/xml/stream/Location;Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .param p1, "loc"    # Ljavax/xml/stream/Location;
    .param p2, "msg"    # Ljava/lang/String;
    .param p3, "severity"    # I
    .param p4, "type"    # Ljava/lang/String;

    .line 52
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 53
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mLocation:Ljavax/xml/stream/Location;

    .line 54
    iput-object p2, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mMessage:Ljava/lang/String;

    .line 55
    iput p3, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mSeverity:I

    .line 56
    iput-object p4, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mType:Ljava/lang/String;

    .line 57
    return-void
.end method


# virtual methods
.method public getLocation()Ljavax/xml/stream/Location;
    .locals 1

    .line 94
    iget-object v0, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mLocation:Ljavax/xml/stream/Location;

    return-object v0
.end method

.method public getMessage()Ljava/lang/String;
    .locals 1

    .line 99
    iget-object v0, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mMessage:Ljava/lang/String;

    return-object v0
.end method

.method public getReporter()Lorg/codehaus/stax2/validation/XMLValidator;
    .locals 1

    .line 122
    iget-object v0, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mReporter:Lorg/codehaus/stax2/validation/XMLValidator;

    return-object v0
.end method

.method public getSeverity()I
    .locals 1

    .line 105
    iget v0, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mSeverity:I

    return v0
.end method

.method public getType()Ljava/lang/String;
    .locals 1

    .line 113
    iget-object v0, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mType:Ljava/lang/String;

    return-object v0
.end method

.method public setLocation(Ljavax/xml/stream/Location;)V
    .locals 0
    .param p1, "l"    # Ljavax/xml/stream/Location;

    .line 82
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mLocation:Ljavax/xml/stream/Location;

    return-void
.end method

.method public setReporter(Lorg/codehaus/stax2/validation/XMLValidator;)V
    .locals 0
    .param p1, "v"    # Lorg/codehaus/stax2/validation/XMLValidator;

    .line 89
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mReporter:Lorg/codehaus/stax2/validation/XMLValidator;

    return-void
.end method

.method public setType(Ljava/lang/String;)V
    .locals 0
    .param p1, "t"    # Ljava/lang/String;

    .line 77
    iput-object p1, p0, Lorg/codehaus/stax2/validation/XMLValidationProblem;->mType:Ljava/lang/String;

    return-void
.end method

.method public toException()Lorg/codehaus/stax2/validation/XMLValidationException;
    .locals 1

    .line 71
    invoke-static {p0}, Lorg/codehaus/stax2/validation/XMLValidationException;->createException(Lorg/codehaus/stax2/validation/XMLValidationProblem;)Lorg/codehaus/stax2/validation/XMLValidationException;

    move-result-object v0

    return-object v0
.end method
