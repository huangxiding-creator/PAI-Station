.class public abstract Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;
.super Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;
.source "ConstantPoolEntry.java"


# static fields
.field public static final CP_Class:B = 0x7t

.field public static final CP_Double:B = 0x6t

.field public static final CP_Fieldref:B = 0x9t

.field public static final CP_Float:B = 0x4t

.field public static final CP_Integer:B = 0x3t

.field public static final CP_InterfaceMethodref:B = 0xbt

.field public static final CP_Long:B = 0x5t

.field public static final CP_Methodref:B = 0xat

.field public static final CP_NameAndType:B = 0xct

.field public static final CP_String:B = 0x8t

.field public static final CP_UTF8:B = 0x1t


# instance fields
.field protected globalIndex:I

.field tag:B


# direct methods
.method constructor <init>(BI)V
    .locals 0
    .param p1, "tag"    # B
    .param p2, "globalIndex"    # I

    .line 58
    invoke-direct {p0}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ClassFileEntry;-><init>()V

    .line 59
    iput-byte p1, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;->tag:B

    .line 60
    iput p2, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;->globalIndex:I

    .line 61
    return-void
.end method


# virtual methods
.method public doWrite(Ljava/io/DataOutputStream;)V
    .locals 1
    .param p1, "dos"    # Ljava/io/DataOutputStream;
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 75
    iget-byte v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;->tag:B

    invoke-virtual {p1, v0}, Ljava/io/DataOutputStream;->writeByte(I)V

    .line 76
    invoke-virtual {p0, p1}, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;->writeBody(Ljava/io/DataOutputStream;)V

    .line 77
    return-void
.end method

.method public abstract equals(Ljava/lang/Object;)Z
.end method

.method public getGlobalIndex()I
    .locals 1

    .line 82
    iget v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;->globalIndex:I

    return v0
.end method

.method public getTag()B
    .locals 1

    .line 67
    iget-byte v0, p0, Lorg/apache/commons/compress/harmony/unpack200/bytecode/ConstantPoolEntry;->tag:B

    return v0
.end method

.method public abstract hashCode()I
.end method

.method protected abstract writeBody(Ljava/io/DataOutputStream;)V
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation
.end method
