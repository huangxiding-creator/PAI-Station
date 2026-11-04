.class public final Lcom/fasterxml/aalto/impl/ErrorConsts;
.super Ljava/lang/Object;
.source "ErrorConsts.java"


# static fields
.field public static ERR_INTERNAL:Ljava/lang/String;

.field public static ERR_NS_EMPTY:Ljava/lang/String;

.field public static ERR_NS_REDECL_XML:Ljava/lang/String;

.field public static ERR_NS_REDECL_XMLNS:Ljava/lang/String;

.field public static ERR_NS_REDECL_XMLNS_URI:Ljava/lang/String;

.field public static ERR_NS_REDECL_XML_URI:Ljava/lang/String;

.field public static ERR_NS_UNDECLARED:Ljava/lang/String;

.field public static ERR_NS_UNDECLARED_FOR_ATTR:Ljava/lang/String;

.field public static ERR_NULL_ARG:Ljava/lang/String;

.field public static ERR_STATE_NOT_ELEM:Ljava/lang/String;

.field public static ERR_STATE_NOT_PI:Ljava/lang/String;

.field public static ERR_STATE_NOT_STELEM:Ljava/lang/String;

.field public static ERR_STATE_NOT_STELEM_OR_TEXT:Ljava/lang/String;

.field public static ERR_WF_DUP_ATTRS:Ljava/lang/String;

.field public static ERR_WF_PI_XML_TARGET:Ljava/lang/String;

.field public static SUFFIX_IN_EPILOG:Ljava/lang/String;

.field public static SUFFIX_IN_PROLOG:Ljava/lang/String;

.field public static SUFFIX_IN_TREE:Ljava/lang/String;

.field public static VERR_ANY:Ljava/lang/String;

.field public static VERR_EMPTY:Ljava/lang/String;

.field public static VERR_NON_MIXED:Ljava/lang/String;

.field public static WERR_ATTR_NO_ELEM:Ljava/lang/String;

.field public static WERR_CDATA_CONTENT:Ljava/lang/String;

.field public static WERR_COMMENT_CONTENT:Ljava/lang/String;

.field public static WERR_DUP_XML_DECL:Ljava/lang/String;

.field public static WERR_NAME_EMPTY:Ljava/lang/String;

.field public static WERR_NAME_ILLEGAL_CHAR:Ljava/lang/String;

.field public static WERR_NAME_ILLEGAL_FIRST_CHAR:Ljava/lang/String;

.field public static WERR_NO_ESCAPING:Ljava/lang/String;

.field public static WERR_NS_NO_ELEM:Ljava/lang/String;

.field public static WERR_PI_CONTENT:Ljava/lang/String;

.field public static WERR_PROLOG_CDATA:Ljava/lang/String;

.field public static WERR_PROLOG_ENTITY:Ljava/lang/String;

.field public static WERR_PROLOG_NO_ROOT:Ljava/lang/String;

.field public static WERR_PROLOG_SECOND_ROOT:Ljava/lang/String;

.field public static WERR_SPACE_CONTENT:Ljava/lang/String;

.field public static WT_ATTR_DECL:Ljava/lang/String;

.field public static WT_DT_DECL:Ljava/lang/String;

.field public static WT_ELEM_DECL:Ljava/lang/String;

.field public static WT_ENT_DECL:Ljava/lang/String;

.field public static WT_NS_DECL:Ljava/lang/String;

.field public static WT_VALIDATION:Ljava/lang/String;

.field public static WT_XML_DECL:Ljava/lang/String;

.field public static W_MIXED_ENCODINGS:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 21
    const-string v0, "Internal error"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_INTERNAL:Ljava/lang/String;

    .line 22
    const-string v0, "Illegal to pass null as argument"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NULL_ARG:Ljava/lang/String;

    .line 26
    const-string v0, "Element <{0}> has EMPTY content specification; can not contain {1}"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->VERR_EMPTY:Ljava/lang/String;

    .line 27
    const-string v0, "Element <{0}> has non-mixed content specification; can not contain non-white space text, or any CDATA sections"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->VERR_NON_MIXED:Ljava/lang/String;

    .line 28
    const-string v0, "Element <{0}> has ANY content specification; can not contain {1}"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->VERR_ANY:Ljava/lang/String;

    .line 32
    const-string v0, "Current state not START_ELEMENT"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM:Ljava/lang/String;

    .line 33
    const-string v0, "Current state not START_ELEMENT or END_ELEMENT"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_ELEM:Ljava/lang/String;

    .line 34
    const-string v0, "Current state not PROCESSING_INSTRUCTION"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_PI:Ljava/lang/String;

    .line 35
    const-string v0, "Current state not START_ELEMENT, CHARACTERS or CDATA"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_STATE_NOT_STELEM_OR_TEXT:Ljava/lang/String;

    .line 39
    const-string v0, " in prolog"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_PROLOG:Ljava/lang/String;

    .line 40
    const-string v0, " in epilog"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_EPILOG:Ljava/lang/String;

    .line 41
    const-string v0, " in xml document"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->SUFFIX_IN_TREE:Ljava/lang/String;

    .line 43
    const-string v0, "Illegal processing instruction target: \'xml\' (case insensitive) is reserved by the xml specification"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_WF_PI_XML_TARGET:Ljava/lang/String;

    .line 46
    const-string v0, "Duplicate attributes \"{0}\" (index {1}), \"{2}\" (index {3})"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_WF_DUP_ATTRS:Ljava/lang/String;

    .line 51
    const-string v0, "Undeclared namespace prefix \"{0}\""

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_UNDECLARED:Ljava/lang/String;

    .line 52
    const-string v0, "Undeclared namespace prefix \"{0}\" (for attribute \"{1}\")"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_UNDECLARED_FOR_ATTR:Ljava/lang/String;

    .line 54
    const-string v0, "Trying to redeclare prefix \'xml\' from its default URI \'http://www.w3.org/XML/1998/namespace\' to \"{0}\""

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XML:Ljava/lang/String;

    .line 58
    const-string v0, "Trying to declare prefix \'xmlns\' (illegal as per NS 1.1 #4)"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XMLNS:Ljava/lang/String;

    .line 60
    const-string v0, "Trying to bind URI \'http://www.w3.org/XML/1998/namespace to prefix \"{0}\" (can only bind to \'xml\')"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XML_URI:Ljava/lang/String;

    .line 63
    const-string v0, "Trying to bind URI \'http://www.w3.org/2000/xmlns/ to prefix \"{0}\" (can not be explicitly bound)"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_REDECL_XMLNS_URI:Ljava/lang/String;

    .line 66
    const-string v0, "Non-default namespace can not map to empty URI (as per Namespace 1.0 # 2) in XML 1.0 documents"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->ERR_NS_EMPTY:Ljava/lang/String;

    .line 71
    const-string v0, "Trying to output a CDATA block outside main element tree (in prolog or epilog)"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_CDATA:Ljava/lang/String;

    .line 73
    const-string v0, "Trying to output an entity reference outside main element tree (in prolog or epilog)"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_ENTITY:Ljava/lang/String;

    .line 75
    const-string v0, "Trying to output second root, <{0}>"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_SECOND_ROOT:Ljava/lang/String;

    .line 77
    const-string v0, "Trying to write END_DOCUMENT when document has no root (ie. trying to output empty document)."

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PROLOG_NO_ROOT:Ljava/lang/String;

    .line 79
    const-string v0, "Can not output XML declaration, after other output has already been done."

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_DUP_XML_DECL:Ljava/lang/String;

    .line 82
    const-string v0, "Illegal input: CDATA block has embedded \']]>\' in it (index {0})"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_CDATA_CONTENT:Ljava/lang/String;

    .line 84
    const-string v0, "Illegal input: comment content has embedded \'--\' in it (index {0})"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_COMMENT_CONTENT:Ljava/lang/String;

    .line 86
    const-string v0, "Illegal input: processing instruction content has embedded \'?>\' in it (index {0})"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_PI_CONTENT:Ljava/lang/String;

    .line 87
    const-string v0, "Illegal input: {0} contains a character (code {1}) that can only be output as character entity"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NO_ESCAPING:Ljava/lang/String;

    .line 89
    const-string v0, "Illegal input: SPACE content has a non-whitespace character (code {0}) in it (index {1})"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_SPACE_CONTENT:Ljava/lang/String;

    .line 92
    const-string v0, "Trying to write an attribute when there is no open start element."

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_ATTR_NO_ELEM:Ljava/lang/String;

    .line 94
    const-string v0, "Trying to write a namespace declaration when there is no open start element."

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NS_NO_ELEM:Ljava/lang/String;

    .line 97
    const-string v0, "Illegal to pass empty name"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NAME_EMPTY:Ljava/lang/String;

    .line 99
    const-string v0, "Illegal first name character {0}"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NAME_ILLEGAL_FIRST_CHAR:Ljava/lang/String;

    .line 100
    const-string v0, "Illegal name character {0}"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WERR_NAME_ILLEGAL_CHAR:Ljava/lang/String;

    .line 106
    const-string v0, "entity declaration"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_ENT_DECL:Ljava/lang/String;

    .line 107
    const-string v0, "element declaration"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_ELEM_DECL:Ljava/lang/String;

    .line 108
    const-string v0, "attribute declaration"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_ATTR_DECL:Ljava/lang/String;

    .line 109
    const-string/jumbo v0, "xml declaration"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_XML_DECL:Ljava/lang/String;

    .line 110
    const-string v0, "doctype declaration"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_DT_DECL:Ljava/lang/String;

    .line 111
    const-string v0, "namespace declaration"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_NS_DECL:Ljava/lang/String;

    .line 117
    const-string v0, "schema validation"

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->WT_VALIDATION:Ljava/lang/String;

    .line 121
    const-string v0, "Inconsistent text encoding; declared as \"{0}\" in xml declaration, application had passed \"{1}\""

    sput-object v0, Lcom/fasterxml/aalto/impl/ErrorConsts;->W_MIXED_ENCODINGS:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 0

    .line 17
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static throwInternalError()V
    .locals 1

    .line 161
    const/4 v0, 0x0

    invoke-static {v0}, Lcom/fasterxml/aalto/impl/ErrorConsts;->throwInternalError(Ljava/lang/String;)V

    .line 162
    return-void
.end method

.method public static throwInternalError(Ljava/lang/String;)V
    .locals 3
    .param p0, "type"    # Ljava/lang/String;

    .line 166
    const-string v0, "Internal error"

    .line 167
    .local v0, "msg":Ljava/lang/String;
    if-eqz p0, :cond_0

    .line 168
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, ": "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 170
    :cond_0
    new-instance v1, Ljava/lang/RuntimeException;

    invoke-direct {v1, v0}, Ljava/lang/RuntimeException;-><init>(Ljava/lang/String;)V

    throw v1
.end method

.method public static tokenTypeDesc(I)Ljava/lang/String;
    .locals 2
    .param p0, "type"    # I

    .line 131
    packed-switch p0, :pswitch_data_0

    .line 157
    :pswitch_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "["

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0, p0}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "]"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0

    .line 144
    :pswitch_1
    const-string v0, "CDATA"

    return-object v0

    .line 153
    :pswitch_2
    const-string v0, "DTD"

    return-object v0

    .line 155
    :pswitch_3
    const-string v0, "ENTITY_REFERENCE"

    return-object v0

    .line 139
    :pswitch_4
    const-string v0, "END_DOCUMENT"

    return-object v0

    .line 137
    :pswitch_5
    const-string v0, "START_DOCUMENT"

    return-object v0

    .line 146
    :pswitch_6
    const-string v0, "SPACE"

    return-object v0

    .line 149
    :pswitch_7
    const-string v0, "COMMENT"

    return-object v0

    .line 142
    :pswitch_8
    const-string v0, "CHARACTERS"

    return-object v0

    .line 151
    :pswitch_9
    const-string v0, "PROCESSING_INSTRUCTION"

    return-object v0

    .line 135
    :pswitch_a
    const-string v0, "END_ELEMENT"

    return-object v0

    .line 133
    :pswitch_b
    const-string v0, "START_ELEMENT"

    return-object v0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_b
        :pswitch_a
        :pswitch_9
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_0
        :pswitch_2
        :pswitch_1
    .end packed-switch
.end method
